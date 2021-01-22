//
//  SubEventsTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/22.
//

import UIKit

class SubEventsTableViewController: UITableViewController {

   
    @IBOutlet var subEventTableView: UITableView!
    
    let subEvents = [SubEvent(subEventName: "test", subEventIsDone: true)]
    
    //let subEvents: [SubEvent] = api.callSubEvent()
    
    let subEventCellIdentifier = "SubEventCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        subEventTableView.dataSource = self
        subEventTableView.delegate = self

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dummySubEvents.count
        if subEvents.count < 1 {
            return 1
        }
        return subEvents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // return UITableViewCell
        
        let cell = subEventTableView.dequeueReusableCell(withIdentifier: subEventCellIdentifier, for: indexPath) as! SubEventCell

        let isDone = subEvents[indexPath.row].subEventIsDone

        // temp image
        var imageName = "importance"
        imageName += isDone ? "_filled" : "_blank"

        // 반복되는 셀에는 이미지뷰 아웃렛 안됨?
        cell.imageView?.image = UIImage(named: imageName)

        let labelText = subEvents[indexPath.row].subEventName

        // cell.subEventName.text = subEvents[indexPath.row].eventName


        if isDone {
            cell.subEventNameLabel.textColor = UIColor.systemGray4
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: labelText)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: 2,
                                         range: NSMakeRange(0, attributeString.length))

            cell.subEventNameLabel.attributedText = attributeString
            
        } else {
            cell.subEventNameLabel.text = labelText
        }

        return cell
    }
    
}
