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
    let events: [Event] = api.realm.objects(Event.self).map { $0 }
    
    var dDay: String = ""
    var eventName: String = ""
    var progressPercent: Float = 0.0
    var selectedCell:Int = 0
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
   
    //private var subGoals: Results<SubEvent>!
    
    //var myEvents = Event()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events[selectedCell].subEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
        cell.textLabel?.text = events[selectedCell].subEvents[indexPath.row].subEventName
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.dataSource = self
    }
    
   

}
