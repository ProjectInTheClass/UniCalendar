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
        } else if event.subEvents.count == 0 && event.eventIsDone == false{
            cell.imageView?.image = UIImage(named: "importance_blank")
            cell.subEventNameLabel.attributedText = NSMutableAttributedString(string: "새로운 세부 목표를 등록해주세요🤓")
            cell.subEventNameLabel.textColor = UIColor.lightGray
            cell.subEventNameLabel.font = UIFont(name: "System", size: 12)
            cell.subEventNameLabel.textAlignment = .left

        } else if event.subEvents.count == 0 && event.eventIsDone == true{
            cell.imageView?.image = UIImage(named: "importance_filled")
            cell.subEventNameLabel.attributedText = NSMutableAttributedString(string: "모두 완료되었어요!😃")
            cell.subEventNameLabel.textColor = UIColor.lightGray
            cell.subEventNameLabel.font = UIFont(name: "System", size: 12)
            cell.subEventNameLabel.textAlignment = .left
            
            let attributeString : NSMutableAttributedString = NSMutableAttributedString(string: cell.subEventNameLabel.text!)
            
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSMakeRange(0, attributeString.length))
            
            cell.subEventNameLabel.attributedText = attributeString
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.event.subEvents.count >= 1 {
            let beforeProcess: Float = Float(self.event.subEvents.filter{s in s.subEventIsDone == true}.count) / Float(self.event.subEvents.count)
            
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
            
            let afterProcess: Float = Float(numOfIsDone)/Float(event.subEvents.count)
            
            print("진행률 변경전: \(beforeProcess)")
            print("진행률 변경후: \(afterProcess)")
            print("진행단계 같은가요?: \(isSameStep(before: beforeProcess, after: afterProcess))")
            LocalNotificationManager().printCountOfNotifications()
            
            // 진행 단계 변경
            if !isSameStep(before: beforeProcess, after: afterProcess) {
                // 현재 이벤트의 알림 리스트 가져옴
                let notificationIDsOfcurrentEvent: [String] = event.pushAlarmID.map({(push: PushAlarm) -> String in return push.id })
                
                print("현재이벤트 알림id 개수 \(notificationIDsOfcurrentEvent.count)")
                // 기존 알림 삭제
                EventAddTableViewController().removeNotifications(notificationIds: notificationIDsOfcurrentEvent)

                // 새로운 진행 단계에 맞는 알림 설정
                //EventAddTableViewController().savePushNotification(event: event, step: <#T##Int#>, frequency: <#T##Int#>, time: <#T##Int#>, daysOfWeek: <#T##[Int]?#>)
                
            }
            print("\nStepChanged")
            LocalNotificationManager().printCountOfNotifications()
            // removePendingNotification(identifiers: event.notificationId)
            
            if self.event.subEvents.count == numOfIsDone {
                try! api.realm.write(){
                    self.event.eventIsDone = true
                }
                // TODO: 여기서 계획된 알림 삭제?
            }
            print("event is done?: \(event.eventIsDone)")
            tableView.reloadData()
            
            // 소목표 체크 변경시 ProgressBar Percent 바꿔주기
            belongedContainer?.updateProgressBar()
        } else if event.subEvents.count == 0 && event.eventIsDone == true {
            belongedContainer?.updateProgressBar()
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
    
    
    func getStepByProcess(process: Float) -> String {
        if process > 1 || process < 0 {
            return "error"
        }
        var step: String
        if process <= 0.25 {
            step = "Beginning"
        } else if process <= 0.5 {
            step = "EarlyMiddle"
        } else if process <= 0.75 {
            step = "LateMiddle"
        } else if process < 1.0 {
            step = "End"
        } else {
            step = "Done"
        }
        return step
    }
    func isSameStep(before: Float, after: Float) -> Bool {
        let beforeProcessStep: String = getStepByProcess(process: before)
        let afterProcessStep: String = getStepByProcess(process: after)
        
        return (beforeProcessStep == afterProcessStep)
    }
}
