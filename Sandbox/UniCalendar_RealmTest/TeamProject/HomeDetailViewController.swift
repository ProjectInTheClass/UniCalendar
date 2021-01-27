//
//  HomeDetailViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/17.
//

import UIKit
import RealmSwift

var buttonPressed: Int = 0

class HomeDetailViewController: UIViewController, UITextFieldDelegate {
  
    //let subGoals: [String] = ["소목표1", "소목표2", "소목표3"]
    var events: [Event] = api.callNotPassedEvent()
    
    var dDay: String = ""
    var eventName: String = ""

    var selectedCell:Int = 0
    
    var staticText : String = ""
    
    // @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var subEventAddTextField: UITextField!
    @IBOutlet weak var subEventAddButton: UIButton!
    
    @IBAction func subEventAddButtonTapped(_ sender: Any) {
        let event = self.events[selectedCell]
        let subEventsVC = SubEventsTableViewController()
        
        let beforeProcess: Float = self.progressView.progress
        
        guard let newSubEventName: String = subEventAddTextField.text, !newSubEventName.isEmpty else {
            return
        }
        let newSubEvent: SubEvent = SubEvent(subEventName: newSubEventName, subEventIsDone: false)
        try? api.realm.write() {
            event.subEvents.append(newSubEvent)
            api.realm.add([newSubEvent])
            //SubEvent(subEventName: newSubEventName, subEventIsDone: false)
        }
        updateProgressBar()
        
        // 진행률 변경 체크
        var numOfIsDone = 0
        for i in 0..<event.subEvents.count {
            if event.subEvents[i].subEventIsDone == true{
                numOfIsDone += 1
            }
        }
        if event.subEvents.count == 0 {
            numOfIsDone = 0
        }
        
        let afterProcess: Float = self.progressView.progress
        
        
        if beforeProcess != afterProcess {
            // 현재 이벤트의 알림 리스트 가져옴
            // (db 수정 전)
            let notificationIDsOfcurrentEvent: [String] = event.pushAlarmID.map{ $0.id }
            
            print("현재이벤트 알림id 개수 \(notificationIDsOfcurrentEvent.count)")
            // 알림 센터에서 기존 알림 삭제
            EventAddTableViewController().removeNotifications(notificationIds: notificationIDsOfcurrentEvent)
            
            // step 0~3 : begin~end
            // step 4: event is Done, print complete message, return immediately
            EventAddTableViewController().savePushNotification(event: event, step: subEventsVC.getStepByProcess(process: afterProcess), pushAlarmSetting: event.pushAlarmSetting ?? PushAlarmSetting())
        }
        print("\nStepChanged")
        LocalNotificationManager().printCountOfNotifications()
                
        subEventAddTextField.text = ""
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    //private var subGoals: Results<SubEvent>!
    
    //var myEvents = Event()
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        //let beforeSortingEvent = events
        //staticText = events[selectedCell].eventName
        events = api.callNotPassedEvent()
        view.reloadInputViews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSubEventTable" {
            let view = segue.destination as? SubEventsTableViewController
            view?.event = events[selectedCell]
            view?.belongedContainer = self
        } else if segue.identifier == "ToEdit" {
            let view = segue.destination as? EventEditTableViewController
            view?.selected = selectedCell
//        } else if segue.identifier == "unwindToHomeFromDetail" {
//            let view = segue.destination as? HomeViewController
            
            
        }
    }
    
    func checkDone() {
        var countTrue: Int = 0
        let event = events[selectedCell]
        for subEvent in event.subEvents {
            if subEvent.subEventIsDone == true {
                countTrue += 1
            }
        }
        
        if countTrue == event.subEvents.count {
            try? api.realm.write(){
                event.eventIsDone = true
            }
        }
        
        events = api.callEvent()
    }
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: "ToEdit", sender: selectedCell)
    }
    
    @IBAction func checkAllTrue(_ sender: Any) {
        let event = events[selectedCell]
        for loopSub in event.subEvents {
            try? api.realm.write(){
                loopSub.subEventIsDone = true
            }
        }
        
        if event.subEvents.count == 0 {
            try? api.realm.write(){
                event.eventIsDone = true
            }
        }
        //buttonPressed = 1
    
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        events = api.callNotPassedEvent()
        updateProgressBar()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subEventAddTextField.delegate = self
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        subEventAddTextField.resignFirstResponder()
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let event = events[selectedCell]
        
        let today = df.date(from: df.string(from : Date.init()))
        let dDay = df.date(from: df.string(from: event.eventDday))!

        let interval = dDay.timeIntervalSince(today!)
        let d = Int(interval / 86400)
        
        if d == 0 {
            dDayLabel.text = "D-DAY"
        } else {
            dDayLabel.text = "D-" + String(d)
        }
        dDayLabel.sizeToFit()
        
        eventNameLabel.text = event.eventName
        updateProgressBar()
        
        // debug notification
        print("\(event.eventName) has \(event.pushAlarmID.count) alarms\n")
    }
    
    func updateProgressBar () {
        let event = self.events[selectedCell]
        var subIsDoneNum: Int = 0
        var progressPercent: Float = 0.0
        
        if event.subEvents.count != 0 {
            subIsDoneNum = event.subEvents.filter(
                { (sub: SubEvent) -> Bool in return
                sub.subEventIsDone == true }).count
            
            progressPercent = Float(subIsDoneNum) / Float(event.subEvents.count)
        } else if event.subEvents.count == 0 && event.eventIsDone == true {
            progressPercent = 1
        }
        progressView.setProgress(progressPercent, animated: false)
        progressPercentLabel.text = String(round(progressPercent*1000)/10) + "%"
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        checkDone()
    }

}
