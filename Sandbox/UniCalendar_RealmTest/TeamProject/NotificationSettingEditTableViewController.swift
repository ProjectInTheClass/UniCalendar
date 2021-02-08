//
//  NotificationSettingEditTableViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/25.
//

import UIKit

class NotificationSettingEditTableViewController: UITableViewController {
    var alarmSetting: PushAlarmSetting = PushAlarmSetting()
    
    var checkedFrequency: Int = 0
    var checkedDaysOfWeek: [Int] = Array<Int>()
    var checkedTime: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cell = self.tableView.cellForRow(at: IndexPath(row: checkedFrequency, section: 0))
        cell?.accessoryType = UITableViewCell.AccessoryType.checkmark

    }
    @IBAction func cancelModal(_ sender: Any) {
        print("[Detail]Notification Setting Cancel")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeModal(_ sender: Any) {
        print("[Detail]Notification Setting Done")
        performSegue(withIdentifier: "unwindToEventEdit", sender: self)
        
    }
    
    @IBAction func unwindToDetailNotificationSetting(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "unwindToDetailNotificationSetting" {
            print("[Detail]unwind To Detail Notification Setting")
        }
    }
    
}
