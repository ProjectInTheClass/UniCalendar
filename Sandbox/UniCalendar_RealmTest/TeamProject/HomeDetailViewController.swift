//
//  HomeDetailViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/17.
//

import UIKit
import RealmSwift

class HomeDetailViewController: UIViewController, UITableViewDataSource {
  
    //let subGoals: [String] = ["소목표1", "소목표2", "소목표3"]
    
    var dDay: String = ""
    var eventName: String = ""
    var progressPercent: Float = 0.0
    var selectedCell:Int = 0
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    private var events: Results<Event>!
    //private var subGoals: Results<SubEvent>!
    
    //var myEvents = Event()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events[selectedCell].subEvent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = events[selectedCell].subEvent[indexPath.row].subEventName
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool){
        events = API.shared.callEvent()
        //subGoals = API.shared.callSubEvent()
        
        //print(events)
        
        print("Selected Cell : ")
        print(selectedCell)
//        dDayLabel.text = dDay
//        eventNameLabel.text = eventName
//        progressView.setProgress(progressPercent, animated: false)
//        progressPercentLabel.text = "\(progressPercent*100)%"
        
        
        
    }

}
