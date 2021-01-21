//
//  HomeViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/07.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let events: [Event] = api.realm.objects(Event.self).map { $0 }
    
    var selectedCellBefore: Int = 0
    //var myEvent = Event()
    // 섹션당 row 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(eventList.accessibilityElementCount())
        //return eventList.accessibilityElementCount()
        return events.count
    }
    
    // indexPath 각 (section, row)에 맞는 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        
        cell.eventNameLabel.text = event.eventName
        
        cell.dDayLabel.text = dateFormatter.string(from: event.eventDday)
        
        cell.importanceLabel.text = "중요해요"
        //cell.importanceImageLabel.text = String(event.events[indexPath.row].)
        
        cell.progressLabel.text = "영차영차"
//        cell.progressView.setProgress(event.progressPercent, animated: false)
//        cell.progressPercentLabel.text = "\(event.progressPercent*100)%"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "moveToDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        guard let destinationController: HomeDetailViewController = segue.destination as? HomeDetailViewController else { return }
        guard let row = sender as? Int else { return }


        let event = events[row]
        
//        destinationController.dDay = event.eventDday
        destinationController.eventName = event.eventName
        
//       selectedCellBefore =  tableView.indexPathForSelectedRow!.row

        destinationController.selectedCell = row


//        print("Selected Cell Before: \(tableView.indexPathForSelectedRow!.row)")
    
        // TODO: 디테일 탭으로 소목표 넘기기
        
        tableView.deselectRow(at:tableView.indexPathForSelectedRow!, animated: true)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        tableView.dataSource = self
        tableView.delegate = self
        
        
//        try! API.shared.realm.write {
//            API.shared.realm.add(myEvent)
//            API.shared.realm.add(myEvent2)
//        }
    }
    
//    override func viewWillAppear(_ animated: Bool){
//        events = API.shared.callEvent()
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//
//    }
    
}
