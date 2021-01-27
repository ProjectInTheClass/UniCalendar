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
    override func viewWillAppear(_ animated: Bool) {
        print("time \(alarmSetting.checkedTime)")
        print("freq \(alarmSetting.checkedFrequency)")
        


    }
    

}
