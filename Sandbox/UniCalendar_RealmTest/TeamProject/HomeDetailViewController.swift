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
    
   
    //private var subGoals: Results<SubEvent>!
    
    //var myEvents = Event()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // detailTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dDayLabel.text = dDay
        eventNameLabel.text = eventName
        progressView.setProgress(progressPercent, animated: false)
        progressPercentLabel.text = "\(progressPercent*100)%"

    }

}
