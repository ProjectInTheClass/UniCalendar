//
//  HomeViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/07.
//

import UIKit

struct EventItem {
    var eventName: String
    var dDay: String
    var importance: Int
    var importanceImage: String
    var progressPercent: Float
}
let eventItems: [EventItem] = [
    EventItem(eventName: "알고리즘 과제",
              dDay: "D-4",
              importance: 4,
              importanceImage: "OOOO",
              progressPercent: 0.8),
    EventItem(eventName: "연합 동아리 지원 마감",
              dDay: "D-7",
              importance: 3,
              importanceImage: "OOO",
              progressPercent: 0.5),
]

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 섹션당 row 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventItems.count
    }
    
    // indexPath 각 (section, row)에 맞는 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = eventItems[indexPath.row]
        cell.eventNameLabel.text = event.eventName
        cell.dDayLabel.text = event.dDay
        
        cell.importanceLabel.text = "중요해요"
        cell.importanceImageLabel.text = event.importanceImage
        
        cell.progressLabel.text = "영차영차"
        cell.progressView.setProgress(event.progressPercent, animated: false)
        cell.progressPercentLabel.text = "\(event.progressPercent*100)%"
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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
