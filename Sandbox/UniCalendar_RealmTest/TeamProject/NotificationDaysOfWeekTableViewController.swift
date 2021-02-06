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
        checkedDayList.removeAll()
        performSegue(withIdentifier: "unwindToNotificationFromDay", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        
        guard let vc = destView as? NotificationSettingTableViewController else {
            return
        }
        vc.checkedDaysOfWeek = self.checkedDayList.sorted{$0 < $1}
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            if checkedDayList.contains(indexPath.row) {
                if let index = checkedDayList.firstIndex(of: indexPath.row) {
                    checkedDayList.remove(at: index)
                }
            }
            checkedDayList = checkedDayList.filter{ $0 != indexPath.row}
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            checkedDayList.append(indexPath.row)
        }
    }
    
    @IBAction func completeModal(_ sender: Any) {
        performSegue(withIdentifier: "unwindToNotificationFromDay", sender: self)
    }
    
}
