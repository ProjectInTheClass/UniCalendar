//
//  SubEventsTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/22.
//

import UIKit
import Foundation

class SubEventsTableViewController: UITableViewController {

    var event: Event = Event()
    var categories = api.callCategory()
   
    
    // 데이터 변경시 테이블뷰를 불러온 컨트롤러에 변경 값 넘겨주기 위함
    var belongedContainer: HomeDetailViewController?
    
    @IBOutlet var subEventTableView: UITableView!
    
    
    //let subEvents: [SubEvent] = api.callSubEvent()
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    let subEventCellIdentifier = "SubEventCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func loadList(){
            //load data here
            self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if event.subEvents.count < 1 {
            return 1
        }
        return event.subEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return UITableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: subEventCellIdentifier, for: indexPath) as! SubEventCell

        if event.subEvents.count != 0 {
            let subEvent = event.subEvents[indexPath.row]
            
            let isDone = subEvent.subEventIsDone

            // temp image
            var imageName = "importance"
            imageName += isDone ? "_filled" : "_blank"

            // 반복되는 셀에는 이미지뷰 아웃렛 안됨?
            cell.imageView?.image = UIImage(named: imageName)

            let labelText = subEvent.subEventName
            // cell.subEventName.text = subEvents[indexPath.row].eventName
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: labelText)
            // 소목표 완료
            if isDone {
                cell.subEventNameLabel.textColor = UIColor.systemGray4
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                
            // 진행중인 소목표
            } else {
                cell.subEventNameLabel.textColor = UIColor.black
            }
            cell.subEventNameLabel.attributedText = attributeString
            
        // subEvent가 없을때
        } else {
            cell.imageView?.image = UIImage(named: "importance_blank")
            cell.subEventNameLabel.attributedText = NSMutableAttributedString(string: "새로운 세부 목표를 등록해주세요🤓")
            cell.subEventNameLabel.textColor = UIColor.lightGray
            cell.subEventNameLabel.font = UIFont(name: "System", size: 12)
            cell.subEventNameLabel.textAlignment = .left

        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.event.subEvents.count >= 1 {
            try? api.realm.write() {
                // 체크 반전
                self.event.subEvents[indexPath.row].subEventIsDone = !self.event.subEvents[indexPath.row].subEventIsDone
            }
            // TODO: 여기서 이벤트 진행률 변경 체크
            
            var numOfIsDone = 0
            for i in 0..<self.event.subEvents.count {
                if self.event.subEvents[i].subEventIsDone == true{
                    numOfIsDone += 1
                }
            }
            // for debug
            print(numOfIsDone)
            print(event.subEvents.count)
            print("진행률 변경: \(Float(numOfIsDone)/Float(event.subEvents.count))")
            
            if self.event.subEvents.count == numOfIsDone {
                try! api.realm.write(){
                    self.event.eventIsDone = true
                }
                // TODO: 여기서 계획된 알림 삭제?
            }
            print(event.eventIsDone)
            tableView.reloadData()
            
            // 소목표 체크 변경시 ProgressBar Percent 바꿔주기
            belongedContainer?.updateProgressBar()
        } else {
            // Todo
            
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.event.subEvents.count > 0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        
            if self.event.subEvents.count > 0 {
                let selectedSubEvent = self.event.subEvents[indexPath.row]
                try? api.realm.write() {
                    api.realm.delete(selectedSubEvent)
                }
                tableView.reloadData()
                belongedContainer?.updateProgressBar()
            } else { return }
        }
    }
}
