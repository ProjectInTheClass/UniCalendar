//
//  PastEventViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/23.
//

import UIKit
import RealmSwift

class PastEventViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var events: [Event] = api.callDoneEvent()
    
    var imageStringArray : [String] = ["importance_blank", "importance_filled"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PastEventCell", for: indexPath) as! PastEventCell
        let event = events[indexPath.row]
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let today = df.date(from: df.string(from : Date.init()))
        let dDay = df.date(from: df.string(from: event.eventDday))!

        let interval = dDay.timeIntervalSince(today!)
        let d = Int(interval / 86400)
        
        cell.dDayLabel.text = "D+" + String(-Int(d))
        
        cell.eventNameLabel.text = event.eventName
        
        cell.importanceLabel.text = "중요해요"
        
        //중요해요 옆 이미지 표현
        cell.importanceOne.image = UIImage(named: imageStringArray[0])
        cell.importanceTwo.image = UIImage(named: imageStringArray[0])
        cell.importanceThree.image = UIImage(named: imageStringArray[0])
        cell.importanceFour.image = UIImage(named: imageStringArray[0])
        cell.importanceFive.image = UIImage(named: imageStringArray[0])
        
        
        switch event.importance {
        case 1:
            cell.importanceOne.image = UIImage(named: imageStringArray[1])
        case 2:
            cell.importanceOne.image = UIImage(named: imageStringArray[1])
            cell.importanceTwo.image = UIImage(named: imageStringArray[1])
        case 3:
            cell.importanceOne.image = UIImage(named: imageStringArray[1])
            cell.importanceTwo.image = UIImage(named: imageStringArray[1])
            cell.importanceThree.image = UIImage(named: imageStringArray[1])
        case 4:
            cell.importanceOne.image = UIImage(named: imageStringArray[1])
            cell.importanceTwo.image = UIImage(named: imageStringArray[1])
            cell.importanceThree.image = UIImage(named: imageStringArray[1])
            cell.importanceFour.image = UIImage(named: imageStringArray[1])
        default:
            cell.importanceOne.image = UIImage(named: imageStringArray[1])
            cell.importanceTwo.image = UIImage(named: imageStringArray[1])
            cell.importanceThree.image = UIImage(named: imageStringArray[1])
            cell.importanceFour.image = UIImage(named: imageStringArray[1])
            cell.importanceFive.image = UIImage(named: imageStringArray[1])
        }
        //cell.importanceImageLabel.text = String(event.events[indexPath.row].)
        
        cell.progressLabel.text = "영차영차"
        
        var progressPercent: Float = 0
        if event.subEvents.count != 0 {
            var subIsDoneNum = 0
            
            subIsDoneNum = event.subEvents.filter(
                { (sub: SubEvent) -> Bool in return
                sub.subEventIsDone == true }).count
            
            progressPercent = Float(subIsDoneNum) / Float(event.subEvents.count)
           
            cell.progressView.setProgress(progressPercent, animated: false)
            

        }
        
        cell.progressPercentLabel.text = String(round(progressPercent*1000)/10) + "%"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        events = api.callDoneEvent()
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
