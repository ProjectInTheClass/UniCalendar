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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("[Detail] NotificationSetting View Will appaar")
        
        
        self.checkedTime = self.alarmSetting.checkedTime
        self.checkedFrequency = self.alarmSetting.checkedFrequency

        self.checkedDaysOfWeek = Array<Int>(self.alarmSetting.checkedDaysOfWeek)
        
        print("\(checkedTime), \(checkedFrequency)")
        self.tableView.selectRow(at: [0, self.checkedFrequency], animated: false, scrollPosition: UITableView.ScrollPosition.none)
        
        // 선택 회색 해제
        let cell: UITableViewCell = self.tableView.cellForRow(at: [0, self.checkedFrequency])?.selectionStyle = .none
        self.tableView.cellForRow(at: [0, self.checkedFrequency])?.accessoryType = .checkmark
        
        self.tableView.cellForRow(at: [1, self.checkedTime])?.accessoryType = .checkmark
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
