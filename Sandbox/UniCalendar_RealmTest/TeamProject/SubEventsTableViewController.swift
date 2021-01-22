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
    
    @IBOutlet var subEventTableView: UITableView!
    
    
    //let subEvents: [SubEvent] = api.callSubEvent()
    
    let subEventCellIdentifier = "SubEventCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        subEventTableView.dataSource = self
        subEventTableView.delegate = self

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
        
        let cell = subEventTableView.dequeueReusableCell(withIdentifier: subEventCellIdentifier, for: indexPath) as! SubEventCell

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


            if isDone {
                cell.subEventNameLabel.textColor = UIColor.systemGray4
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: labelText)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))

                cell.subEventNameLabel.attributedText = attributeString
                
            } else {
                cell.subEventNameLabel.text = labelText
            }
        } else {
            // subEvent가 없을때
            cell.subEventNameLabel.text = "소목표가 없습니다."
        }
        
        return cell
    }
    
}
