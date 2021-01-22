//
//  HomeDetailViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/17.
//

import UIKit
import RealmSwift

class HomeDetailViewController: UIViewController {
  
    //let subGoals: [String] = ["소목표1", "소목표2", "소목표3"]
    let events: [Event] = api.callEvent()
    
    var dDay: String = ""
    var eventName: String = ""
    var progressPercent: Float = 0.0
    var selectedCell:Int = 0
    
    // @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
   
    //private var subGoals: Results<SubEvent>!
    
    //var myEvents = Event()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSubEventTable" {
            let view = segue.destination as? SubEventsTableViewController
            view?.event = events[selectedCell]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // detailTableView.dataSource = self
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
        dDayLabel.text = "D - " + String(d)
        eventNameLabel.text = event.eventName
        
        var progressPercent: Float = 0
        if event.subEvents.count != 0 {
            var subIsDoneNum = 0
                for sub in event.subEvents{
                    if sub.subEventIsDone == true {
                        subIsDoneNum += 1
                    }
                }
            progressPercent = Float(subIsDoneNum) / Float(event.subEvents.count)
           
            progressView.setProgress(progressPercent, animated: false)
            

        }
            progressPercentLabel.text = String(round(progressPercent*1000)/10) + "%"

    }

}
