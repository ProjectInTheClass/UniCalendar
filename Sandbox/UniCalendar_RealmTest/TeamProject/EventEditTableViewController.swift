//
//  EventEditTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

class EventEditTableViewController: UITableViewController, UITextFieldDelegate {

    var checkedFrequency: Int = 0

    var checkedDaysOfWeek: [Int] = Array<Int>()
    var checkedTime: Int = 0
    
    var categoryString: String = ""
    
    var notificationFrequency: String = ""
    var notificationTime: String = ""
    var frequencyIndexPathRow: Int = -1
    var timeIndexPathRow: Int = -1
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var showImportance: UILabel!
    @IBOutlet weak var importanceSlider: UISlider!
    
    @IBOutlet weak var settledNotificationInfoLabel: UILabel!
   
    @IBOutlet weak var deleteCell: UITableViewCell!
    
    var event = api.callNotPassedEvent()
    var category = api.callCategory()
    
    var selected: Int = 0
    var selectedCategory: Int = 0
    var changedCategory: Bool = false
    var changedNotification:Bool = false
    
    var saveEventName: String = ""
    
    @IBAction func unwindToEventEdit(segue: UIStoryboardSegue){
        switch segue.identifier {
        case "unwindToEventEdit":
            settledNotificationInfoLabel.text = "\(notificationFrequency) \(notificationTime)"
            break
        default:
            break
        }
    }
    
    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.eventName.resignFirstResponder()
        return true
    }
    
    @IBAction func ringVolumeSliderChange(_ sender: UISlider)
    {
        sender.setValue(sender.value.rounded(.down), animated: false)
        showImportance.text = String(Int(importanceSlider.value))
    }
    

    func removeFromBeforeCategory() {
        let beforeCategory = event[selected].parentCategory[0]
        var count: Int = 0
        for events in beforeCategory.eventsInCategory {
            if events.eventName == event[selected].eventName {
                    beforeCategory.eventsInCategory.remove(at: count)
                }
                count += 1
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var count : Int = 0
        
        if segue.identifier == "unwindToDetail"{
            let selectedEvent = event[selected]
            let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
            
            try? api.realm.write(){
                
                if changedCategory == true {
                    removeFromBeforeCategory()
                    category[selectedCategory].eventsInCategory.append(selectedEvent)
                }
                
                selectedEvent.eventName = eventName.text!
                
                saveEventName = eventName.text!
                
                selectedEvent.eventDday = datePicker.date
                let dCalendar = Calendar.current.dateComponents([.year, .month, .day], from: selectedEvent.eventDday)

                selectedEvent.importance = Int(importanceSlider.value)
                if (dCalendar.year! < today.year!) || (dCalendar.year! <= today.year! && dCalendar.month! < today.month!) || (dCalendar.year! <= today.year! && dCalendar.month! <= today.month! && dCalendar.day! < today.day!) {
                    selectedEvent.eventIsPassed = true
                    event = api.callEvent()
                    performSegue(withIdentifier: "unwindToHomeError", sender: nil)
                } else {
                    selectedEvent.eventIsPassed = false
                }
            }
            
            event = api.callNotPassedEvent()
            
            while count < event.count {
                if  event[count].eventName == saveEventName {
                    selected = count
                    break
                }
                count += 1
            }
//            for element in event {
//                if count == selected && element.eventName != saveEventName{
//                    selected = count
//                }
//                count += 1
//            }
            
            guard let view = segue.destination as? HomeDetailViewController else {return}
            
            // 알림 변경시 삭제하고 다시등록
            if changedNotification == true {
                let pushAlarmSetting: PushAlarmSetting = PushAlarmSetting(checkedTime: checkedTime, checkedFrequency: checkedFrequency, checkedDaysOfWeek: checkedDaysOfWeek)
                
                try? api.realm.write() {
                    api.callEvent()[selected].pushAlarmSetting = pushAlarmSetting
                }
                
                let eventProcess:Float = view.progressView.progress
                
                let notificationIDsOfcurrentEvent: [String] = api.callEvent()[selected].pushAlarmID.map{ $0.id }

                EventAddTableViewController().removeNotifications(notificationIds: notificationIDsOfcurrentEvent)

                EventAddTableViewController().savePushNotification(event: api.callEvent()[selected], step: SubEventsTableViewController().getStepByProcess(process: eventProcess), pushAlarmSetting: api.callEvent()[selected].pushAlarmSetting ?? PushAlarmSetting())
            }
            view.selectedCell = selected
            
            
        } else if segue.identifier == "toCategorySelect" {
            guard let navigation = segue.destination as? UINavigationController else {return}
            
            guard let view = navigation.viewControllers[0] as? CategorySelectionEditTableViewController else {return}
    
            view.selected = selected
        } else if segue.identifier == "toNotificationSetting" {
            guard let navigation = segue.destination as? UINavigationController else {return}
            
            guard let view = navigation.viewControllers[0] as? NotificationSettingEditTableViewController else {return}
    
            view.alarmSetting = api.callEvent()[selected].pushAlarmSetting ?? PushAlarmSetting()
        }
    }
    
    @IBAction func complete(_ sender: Any) {
        performSegue(withIdentifier: "unwindToDetail", sender: nil)
    }
    
    
    func deleteEvent() {
        let selectedEvent = event[selected]
        let alert = UIAlertController(title: "⚠️일정 삭제⚠️", message: "일정을 삭제하면 되돌릴 수 없어요!🙅\n그래도 삭제하시겠어요?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("네", comment: "Default action"), style: .default, handler: { _ in
        //NSLog("The \"OK\" alert occured.")
            try? api.realm.write{
                api.realm.delete(selectedEvent)
            }
            
            self.event = api.callEvent()
            self.performSegue(withIdentifier: "unwindToHomeFromEdit", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "아뇨", style: .cancel, handler: { _ in
            //NSLog("The NO alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        if indexPath.row == 0 && tableView.cellForRow(at: indexPath)?.textLabel?.text == "카테고리"{
            performSegue(withIdentifier: "toCategorySelect", sender: nil)
        } else if indexPath.row == 0 && tableView.cellForRow(at: indexPath)?.textLabel?.text == "이 일정 삭제하기" {
            deleteEvent()
        }
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        eventName.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedEvent = event[selected]
        categoryLabel.text = selectedEvent.parentCategory[0].categoryName
        eventName.text = selectedEvent.eventName
        datePicker.date = selectedEvent.eventDday
        showImportance.text = String(selectedEvent.importance)
        importanceSlider.value = Float(selectedEvent.importance)
        self.notificationFrequency = getDayFromCheckedRow(row: self.checkedFrequency)
        settledNotificationInfoLabel.text = "\(self.notificationFrequency) \(self.notificationTime)"
    }
    
    func getTimeFromCheckedRow(row: Int) -> String {
        switch row {
        case 0:
            return "오전 6시"
        case 1:
            return "오전 9시"
        case 2:
            return "오후 12시"
        case 3:
            return "오후 3시"
        case 4:
            return "오후 6시"
        case 5:
            return "오후 9시"
        default:
            return ""
        }
    }

    func getDayFromCheckedRow(row: Int) -> String {
        switch row {
        case 0:
            return "없음"
        case 1:
            return "매일"
        case 2:
            return  getDayStringFromDaysArray(dayList: checkedDaysOfWeek)
        default:
            return "선택 되지 않음"
        }
    }

    func getDayStringFromDaysArray(dayList: [Int]) -> String {
        if dayList.isEmpty {
            return ""
        }
        let resultDayString: String = dayList.reduce("매주 ", {(prev: String, day: Int) -> String in
            var dayString: String {
                switch day {
                case 0:
                    return "월"
                case 1:
                    return "화"
                case 2:
                    return "수"
                case 3:
                    return "목"
                case 4:
                    return "금"
                case 5:
                    return "토"
                case 6:
                    return "일"
                default:
                    return ""
                }
            }
            return prev + dayString + " "
        })
        return resultDayString
    }
 

}
