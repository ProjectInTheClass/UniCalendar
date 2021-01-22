//
//  NotificationDaysOfWeekTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/22.
//

import UIKit

class NotificationDaysOfWeekTableViewController: UITableViewController {

    var checkedDayList: [Int] = Array<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }

    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        
        guard let vc = destView as? NotificationSettingTableViewController else {
            return
        }
        vc.checkedDaysOfWeek = self.checkedDayList.sorted{$0 < $1}
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if !checkedDayList.contains(indexPath.row) {
            checkedDayList.append(indexPath.row)
        }
    }
    
    @IBAction func completeModal(_ sender: Any) {
        performSegue(withIdentifier: "unwindToNotificationFromDay", sender: self)
    }
    
}
