//
//  HomeDetailViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/17.
//

import UIKit
import RealmSwift

class HomeDetailViewController: UIViewController, UITextFieldDelegate {
  
    //let subGoals: [String] = ["소목표1", "소목표2", "소목표3"]
    var events: [Event] = api.callNotDoneEvent()
    
    var dDay: String = ""
    var eventName: String = ""

    var selectedCell:Int = 0
    
    // @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var subEventAddTextField: UITextField!
    @IBOutlet weak var subEventAddButton: UIButton!
    
    @IBAction func subEventAddButtonTapped(_ sender: Any) {
        let newSubEventName: String = subEventAddTextField.text ?? ""
        let newSubEvent: SubEvent = SubEvent(subEventName: newSubEventName, subEventIsDone: false)
        try? api.realm.write() {
            self.events[selectedCell].subEvents.append(newSubEvent)
            api.realm.add([newSubEvent])
            //SubEvent(subEventName: newSubEventName, subEventIsDone: false)
        }
        updateProgressBar()
        subEventAddTextField.text = ""
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
    }
    //private var subGoals: Results<SubEvent>!
    
    //var myEvents = Event()
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        events = api.callNotDoneEvent()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSubEventTable" {
            let view = segue.destination as? SubEventsTableViewController
            view?.event = events[selectedCell]
            view?.belongedContainer = self
        } else if segue.identifier == "ToEdit" {
            let view = segue.destination as? EventEditTableViewController
            view?.selected = selectedCell
        }
    }
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: "ToEdit", sender: selectedCell)
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
        
        if event.subEvents.count == 0 {
            //
        }
        
        let today = df.date(from: df.string(from : Date.init()))
        let dDay = df.date(from: df.string(from: event.eventDday))!

        let interval = dDay.timeIntervalSince(today!)
        let d = Int(interval / 86400)
        
        if d == 0 {
            dDayLabel.text = "D-DAY"
        } else {
            dDayLabel.text = "D-" + String(d)
        }
        
        eventNameLabel.text = event.eventName
        updateProgressBar()
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
        }
        progressView.setProgress(progressPercent, animated: false)
        progressPercentLabel.text = String(round(progressPercent*1000)/10) + "%"
        
    }

}
