//
//  HomeViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/07.
//

import UIKit
import RealmSwift

struct EventItem {
    var eventName: String
    var dDay: String
    var importance: Int
    var importanceImage: String
    var progressPercent: Float
}
//let eventItems: [Event] = [
//
//]

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    let category = Category()
    let eventList = EventList()
    
    let event = Event()
    let subEvent = SubEvent()
//    let callEvent = realm.objects(EventList.self)
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // 섹션당 row 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(eventList.accessibilityElementCount())
        return eventList.accessibilityElementCount()

    }
    
    // indexPath 각 (section, row)에 맞는 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = eventList.events[indexPath.row]
        cell.eventNameLabel.text = event.eventName
        
        cell.dDayLabel.text = dateFormatter.string(from: event.eventDday)
        
        cell.importanceLabel.text = "중요해요"
        cell.importanceImageLabel.text = String(event.importance)
        
        cell.progressLabel.text = "영차영차"
//        cell.progressView.setProgress(event.progressPercent, animated: false)
//        cell.progressPercentLabel.text = "\(event.progressPercent*100)%"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationController: HomeDetailViewController = segue.destination as? HomeDetailViewController else { return }
        guard let cell: EventCell = sender as? EventCell else { return }
        
        destinationController.dDay = cell.dDayLabel.text!
        destinationController.eventName = cell.eventNameLabel.text!
        destinationController.progressPercent = cell.progressView.progress
        
        // TODO: 디테일 탭으로 소목표 넘기기
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
