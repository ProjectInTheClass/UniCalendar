//
//  EventAddTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

let api = API.shared

class EventAddTableViewController: UITableViewController, UITextFieldDelegate {
    
    var categoryString: String = ""
    var selectedCategory: Int = 0
    
    var notificationFrequency: String = ""
    var notificationTime: String = ""
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var newEventName: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var showImportance: UILabel!
    @IBOutlet weak var importanceSlider: UISlider!
    
    @IBOutlet weak var settledNotificationInfoLabel: UILabel!
   
    
    var event = api.callEvent()
    var doneEvent = api.callDoneEvent()
    var notDoneEvent = api.callNotDoneEvent()
    var category = api.callCategory()
    
    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        switch seg.identifier {
        case "unwindToAddEventFromCategory":
            categoryLabel.text = category[selectedCategory].categoryName
            break
        case "unwindToAddEventFromNotification":
            settledNotificationInfoLabel.text = "\(notificationFrequency) \(notificationTime)"
            break
        default:
            break
        }
    }
    


    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func completeModal(_ sender: Any) {
        // TODO
        // Add New event to EventList
        save()
        performSegue(withIdentifier: "unwindToHome", sender: (Any).self)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.newEventName.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.newEventName.resignFirstResponder()
//        dismiss(animated: true, completion: nil)
        return true
    }

    
//    @IBAction func changeImportanceBySlider(_ sender: Any) {
//        showImportance.text = String(importanceSlider.value)
//    }
    
    @IBAction func ringVolumeSliderChange(_ sender: UISlider)
    {
        sender.setValue(sender.value.rounded(.down), animated: false)
        showImportance.text = String(Int(importanceSlider.value))
    }
    
    func save() {
        
        
        let pickedDate = dateFormatter.string(from: datePicker.date)
        let d = self.dateFormatter.date(from: pickedDate)
        let dCalendar = Calendar.current.dateComponents([.year, .month, .day], from: d!)
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
        
        if (dCalendar.year! < today.year!) || (dCalendar.year! <= today.year! && dCalendar.month! < today.month!) || (dCalendar.year! <= today.year! && dCalendar.month! <= today.month! && dCalendar.day! < today.day!) {
            let newEvent = Event(eventName: newEventName.text!, eventDday: d!, importance: Int(importanceSlider.value), eventIsDone: true)
            try! api.realm.write(){
                category[selectedCategory].eventsInCategory.append(newEvent)
                api.realm.add([newEvent])
            }
        } else {
            let newEvent = Event(eventName: newEventName.text!, eventDday: d!, importance: Int(importanceSlider.value), eventIsDone: false)
           try! api.realm.write{
               category[selectedCategory].eventsInCategory.append(newEvent)
               api.realm.add([newEvent])
           }
                   
        }
        
    }
    
    func savePushNotification() {
        
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newEventName.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        importanceSlider.value = 2
        showImportance.text = String(Int(importanceSlider.value))
    }
}
