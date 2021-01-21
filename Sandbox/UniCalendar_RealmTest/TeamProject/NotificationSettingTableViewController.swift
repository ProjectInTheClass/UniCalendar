//
//  NotificationSettingTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/21.
//

import UIKit

class NotificationSettingTableViewController: UITableViewController {

    var checkedDay: Int = 0
    var checkedTime: Int = 0

    var lastCheckedIndexPath: IndexPath = IndexPath()
    var isSectionChecked: [Bool] = [false, false]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        print("Notification / prepare")
        guard let vc = destView as? EventAddTableViewController else {
            return
        }
        vc.notificationFrequency = getDayFromCheckedRow(row: checkedDay)
        
        if checkedDay != 0 {
        vc.notificationTime = getTimeFromCheckedRow(row: checkedTime)
        } else {
            vc.notificationTime = ""
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // cancel button
    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // done button
    @IBAction func goToAddEvent(_ sender: Any) {
        performSegue(withIdentifier: "unwindToAddEvent", sender: self)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Todo: 탭 선택 변경 가능하게,,
        // 현재 섹션이 체크가 안되어있으면
        if !isSectionChecked[indexPath.section] {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            switch (indexPath.section) {
            case 0: // frequency section
                self.checkedDay = indexPath.row
                break
            case 1:
                self.checkedTime = indexPath.row
                break
            default:
                print("error")
            }
            isSectionChecked[indexPath.section] = true

        } else { // 현재 섹션이 체크가 되어있으면
            // 기존 체크된 cell을 체크 해제
            if indexPath.section == lastCheckedIndexPath.section {
                tableView.cellForRow(at: lastCheckedIndexPath)?.accessoryType = .none
                
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                
                switch (indexPath.section) {
                case 0: // frequency section
                    self.checkedDay = indexPath.row
                    break
                case 1:
                    self.checkedTime = indexPath.row
                    break
                default:
                    print("error")
                }
            }
        }
        lastCheckedIndexPath = indexPath
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func getTimeFromCheckedRow(row: Int) -> String {
        switch row {
        case 0:
            return "오전 6시"
        case 1:
            return "오전 9시"
        case 2:
            return "오후 12시"
        case 3:
            return "오후 3시"
        case 4:
            return "오후 6시"
        case 5:
            return "오후 9시"
        default:
            return ""
        }
    }
    
    func getDayFromCheckedRow(row: Int) -> String {
        switch row {
        case 0:
            return "없음"
        case 1:
            return "매일"
        case 2:
            return "사용자 설정"
        default:
            return "선택하지 않음"
        }
    }

}
