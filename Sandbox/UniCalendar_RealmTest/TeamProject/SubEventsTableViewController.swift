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
    
    
    let subEventCellIdentifier = "SubEventCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func loadList(){
            //load data here
            self.tableView.reloadData()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if event.subEvents.count < 1 {
            return 1
        }
        return event.subEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return UITableViewCell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: subEventCellIdentifier, for: indexPath) as! SubEventCell
        
        cell.selectionStyle = .none

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
        
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        
        if self.event.subEvents.count >= 1 {
            // let beforeProcess: Float = Float(self.event.subEvents.filter{s in s.subEventIsDone == true}.count) / Float(self.event.subEvents.count)
            let beforeProcess: Float = self.belongedContainer?.progressView.progress ?? 0.0
            
            try? api.realm.write() {
                // 체크 반전
                self.event.subEvents[indexPath.row].subEventIsDone = !self.event.subEvents[indexPath.row].subEventIsDone
            }
            

            // let afterProcess: Float = Float(numOfIsDone)/Float(event.subEvents.count)
            self.belongedContainer?.updateProgressBar()
            let afterProcess: Float = self.belongedContainer?.progressView.progress ?? 0.0
            // 진행률 변경 체크
            print("진행률 변경전: \(beforeProcess)")
            print("진행률 변경후: \(afterProcess)")
            print("진행단계 같은가요?: \(isSameStep(before: beforeProcess, after: afterProcess))")
            LocalNotificationManager().printCountOfNotifications()
            // 진행 단계 변경
            // ** 만약 세부목표가 전부 체크되었으면
            // ** 기존 알림 삭제 이후 isDone체크 해서 완료되었으면 이후에도 삭제
            
            if beforeProcess != afterProcess {
                // 현재 이벤트의 알림 리스트 가져옴
                // (db 수정 전)
                let notificationIDsOfcurrentEvent: [String] = event.pushAlarmID.map{ $0.id }

                // 알림 센터에서 기존 알림 삭제
                EventAddTableViewController().removeNotifications(notificationIds: notificationIDsOfcurrentEvent)
                
                // step 0~4 : begin~end
                // step 5: event is Done
                
                // 삭제하고, 5(done)이 아니면 다시 등록
                if getStepByProcess(process: afterProcess) != 5 {
                    if self.event.eventIsDone == true {
                        try! api.realm.write() {
                            self.event.eventIsDone = false
                        }
                    }
                    EventAddTableViewController().savePushNotification(event: self.event, step: getStepByProcess(process: afterProcess), pushAlarmSetting: self.event.pushAlarmSetting ?? PushAlarmSetting())
                } else { // 5(done)이면 isDone = true로 바꿈
                    try! api.realm.write(){
                        self.event.eventIsDone = true
                    }
                    // 이벤트의 푸쉬알람들 삭제
                    if !self.event.pushAlarmID.isEmpty {
                        EventAddTableViewController().removeNotifications(notificationIds: self.event.pushAlarmID.map{$0.id})
                    }
                }
            }
            LocalNotificationManager().printCountOfNotifications()
            
//            var numOfIsDone = 0
//            for i in 0..<self.event.subEvents.count {
//                if self.event.subEvents[i].subEventIsDone == true{
//                    numOfIsDone += 1
//                }
//            }
            // db 수정 (event.isDone 설정)
//            if self.event.subEvents.count != 0  {
//
//                // 서브이벤트가 있고, 전부 완료되었다면
//                if self.event.subEvents.count == numOfIsDone {
//                    try! api.realm.write(){
//                        self.event.eventIsDone = true
//                    }
//                    // 이벤트의 푸쉬알람들 삭제
//                    if !self.event.pushAlarmID.isEmpty {
//                        EventAddTableViewController().removeNotifications(notificationIds: self.event.pushAlarmID.map{$0.id})
//                    }
//                } else {
//                    try! api.realm.write() {
//                        self.event.eventIsDone = false
//                    }
//                }
//            }
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
            let beforeSubEventCount:Int = event.subEvents.count
            
            self.belongedContainer?.updateProgressBar()
            let beforeProcess:Float = self.belongedContainer?.progressView.progress ?? 0.0
            
            // db에서 세부목표 삭제
            if self.event.subEvents.count > 0 {
                let selectedSubEvent = self.event.subEvents[indexPath.row]
                try? api.realm.write() {
                    api.realm.delete(selectedSubEvent)
                }
                tableView.reloadData()
                belongedContainer?.updateProgressBar()
            } else { return }
            
            let afterSubEventCount:Int  = event.subEvents.count
            
            // 삭제 후 진행률
            let afterProcess:Float = self.belongedContainer?.progressView.progress ?? 0.0
            
            // 진행률이 변했으면 (완료 안된 세부목표를 지운경우)
            if (beforeProcess != afterProcess) || (beforeSubEventCount != afterSubEventCount) {
                // 현재 이벤트의 알림 리스트 가져옴
                // (db 수정 전)
                let notificationIDsOfcurrentEvent: [String] = event.pushAlarmID.map{ $0.id }
                
                print("현재이벤트 알림id 개수 \(notificationIDsOfcurrentEvent.count)")
                
                // 알림 센터에서 기존 알림 삭제
                EventAddTableViewController().removeNotifications(notificationIds: notificationIDsOfcurrentEvent)
                
                // step 0~3 : begin~end
                // step 4: event is Done, print complete message, return immediately
                EventAddTableViewController().savePushNotification(event: self.event, step: getStepByProcess(process: afterProcess), pushAlarmSetting: self.event.pushAlarmSetting ?? PushAlarmSetting())
                
                // push notification db 수정 (event.isDone 설정)
                var numOfIsDone = 0
                for i in 0..<event.subEvents.count {
                    if event.subEvents[i].subEventIsDone == true {
                        numOfIsDone += 1
                    }
                }
                // 이벤트 완료시 db에 isDone 변경, 알림 삭제
                if event.subEvents.count != 0  && (event.subEvents.count == numOfIsDone) {
                    try! api.realm.write(){
                        event.eventIsDone = true
                    }
                    // 이벤트의 푸쉬알람들 삭제
                    if !event.pushAlarmID.isEmpty {
                        EventAddTableViewController().removeNotifications(notificationIds: event.pushAlarmID.map{$0.id})
                    }
                }
            }

            print("\nStepChanged")
        }
    }
    
    
    func getStepByProcess(process: Float) -> Int {
        if process > 1 || process < 0 {
            return -1
        }
        var step: Int
        if process == 0 {
            step = 0
        } else if process <= 0.25 {
            step = 1
        } else if process <= 0.5 {
            step = 2
        } else if process <= 0.75 {
            step = 3
        } else if process < 1.0 {
            step = 4
        } else if process == 1.0 {
            step = 5
        } else {
            step = -1
        }
        return step
    }
    func isSameStep(before: Float, after: Float) -> Bool {
        let beforeProcessStep: Int = getStepByProcess(process: before)
        let afterProcessStep: Int = getStepByProcess(process: after)
        
        return (beforeProcessStep == afterProcessStep)
    }
}


