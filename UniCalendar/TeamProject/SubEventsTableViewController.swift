//
//  SubEventsTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/20.
//

import UIKit

struct SubEvent {
    var eventName: String
    var isDone: Bool
}

class SubEventsTableViewController: UITableViewController {

    @IBOutlet var subEventsTableView: UITableView!
    // @IBOutlet weak var isDoneImageView: UIImageView!
    

    let dummySubEvents: [SubEvent] = [
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: false),
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: false),
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: false),
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: false),
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: true),
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: true),
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: true),
        SubEvent(eventName:"소목표ㅁㄴㅇㄹ", isDone: true),
    ]
    
    let subEventCellIdentifier = "SubEventCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        subEventsTableView.dataSource = self
        subEventsTableView.delegate = self

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummySubEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subEventsTableView.dequeueReusableCell(withIdentifier: subEventCellIdentifier, for: indexPath) as! SubEventCell

        let isDone = dummySubEvents[indexPath.row].isDone
        
        // temp image
        var imageName = "importance"
        imageName += isDone ? "_filled" : "_blank"
    
        // 반복되는 셀에는 이미지뷰 아웃렛 안됨?
        cell.imageView?.image = UIImage(named: imageName)
        
        let labelText = dummySubEvents[indexPath.row].eventName
        
        // cell.subEventName.text = dummySubEvents[indexPath.row].eventName

        
        if isDone {
            cell.subEventName.textColor = UIColor.systemGray4
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: labelText)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: 2,
                                         range: NSMakeRange(0, attributeString.length))
            
            cell.subEventName.attributedText = attributeString
            // todo : 취소선(strikethrough
        } else {
            cell.subEventName.text = labelText
        }

        return cell
    }
    

}
