//
//  HomeViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/07.
//

import UIKit
import RealmSwift
import Foundation

class HomeViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeNavigationTitle: UINavigationItem!
    
    var events: [Event] = api.callNotDoneEvent()
    var selectedCellBefore: Int = 0
    
    var imageStringArray : [String] = ["importance_blank", "importance_filled"]
    
//    func blankImportance() -> UIImage {
//        let importanceImage = UIImage(named: "importance_blank")!
//
//        return importanceImage
//    }
//
//    func fillImportance() -> UIImage{
//        let importanceImage = UIImage(named: "importance_filled")!
//
//        return importanceImage
//    }
//
    
    // 섹션당 row 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
    }
    
    // indexPath 각 (section, row)에 맞는 cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = events[indexPath.row]
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let today = df.date(from: df.string(from : Date.init()))
        let dDay = df.date(from: df.string(from: event.eventDday))!

        let interval = dDay.timeIntervalSince(today!)
        let d = Int(interval / 86400)
        
        cell.dDayLabel.text = "D-" + String(d)
        
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "moveToDetail", sender: indexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailView로 데이터 넘기기
        guard let destinationController: HomeDetailViewController = segue.destination as? HomeDetailViewController else { return }
        guard let row = sender as? Int else { return }

        destinationController.selectedCell = row
    
        tableView.deselectRow(at:tableView.indexPathForSelectedRow!, animated: true)

    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        print("from Add to Home")
        events = api.callEvent()
        // print(events)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableView.dataSource = self
        tableView.delegate = self
    
    }

    override func viewWillAppear(_ animated: Bool) {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko")
        df.dateFormat = "M월 dd일 eeee"
        homeNavigationTitle.title = df.string(from: Date.init())
        
        print("VIEW WILL APPEAR")
        events = api.callNotDoneEvent()
        tableView.reloadData()
    }
    
//    func filledOne() {
//
//    }
//
//    func filledTwo() {
//
//    }
//
//    func filledThree() {
//
//    }
//
//    func filledFour() {
//
//    }
//
//    func filledFive() {
//
//    }
    
}
