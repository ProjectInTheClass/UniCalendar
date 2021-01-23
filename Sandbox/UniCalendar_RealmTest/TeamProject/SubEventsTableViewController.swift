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
    
    // 데이터 변경시 테이블뷰를 불러온 컨트롤러에 변경 값 넘겨주기 위함
    var belongedContainer: HomeDetailViewController?
    
    @IBOutlet var subEventTableView: UITableView!
    
    
    //let subEvents: [SubEvent] = api.callSubEvent()
    
    let subEventCellIdentifier = "SubEventCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
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
            cell.subEventNameLabel.textColor = UIColor.lightGray
            cell.subEventNameLabel.font = UIFont(name: "System", size: 12)
            cell.subEventNameLabel.textAlignment = .left
            cell.subEventNameLabel.text = "새로운 소목표를 등록해주세요🤓"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.event.subEvents.count >= 1 {
            try? api.realm.write() {
                // 체크 반전
                self.event.subEvents[indexPath.row].subEventIsDone = !self.event.subEvents[indexPath.row].subEventIsDone
            }
            tableView.reloadData()
            
            // 소목표 체크 변경시 ProgressBar Percent 바꿔주기
            var subIsDoneNum: Int = 0
            var progressPercent: Float = 0.0
            
            subIsDoneNum = self.event.subEvents.filter({ (sub: SubEvent) -> Bool in return
                sub.subEventIsDone == true
            }).count
            
            progressPercent = Float(subIsDoneNum) / Float(self.event.subEvents.count)
            belongedContainer?.progressView.setProgress(progressPercent, animated: false)
            belongedContainer?.progressPercentLabel.text = String(round(progressPercent*1000)/10) + "%"
        } else {
            // Todo
            
        }
    }
    
}
