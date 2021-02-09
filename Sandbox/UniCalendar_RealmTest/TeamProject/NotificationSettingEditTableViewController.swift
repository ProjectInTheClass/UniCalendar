//
//  NotificationSettingEditTableViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/25.
//

import UIKit

class NotificationSettingEditTableViewController: UITableViewController {
    var alarmSetting: PushAlarmSetting = PushAlarmSetting()
    
    @IBOutlet weak var userSelectDayLabel: UILabel!
    var checkedFrequency: Int = 0
    var checkedDaysOfWeek: [Int] = Array<Int>()
    var checkedTime: Int = 0

    var lastCheckedIndexPathInSection: [IndexPath] = [IndexPath(), IndexPath()]
    var lastCheckedFrequency: Int = -1
    var lastCheckedTime: Int = -1
    
    var isSectionChecked: [Bool] = [false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        guard let vc = destView as? EventEditTableViewController else {
            return
        }
        
        //선택한 값 EventAddTableView에 indexPath로 넘겨서 저장
        vc.frequencyIndexPathRow = lastCheckedFrequency
        vc.timeIndexPathRow = lastCheckedTime
        
        // 0 1 2
        vc.notificationFrequency = getDayFromCheckedRow(row: checkedFrequency)
        
        vc.checkedFrequency = self.checkedFrequency
        vc.checkedDaysOfWeek = self.checkedDaysOfWeek
        
        vc.checkedTime = self.checkedTime
        // checkedDay가 0이면 빈도: 없음 선택이므로, 시간대도 없음
        if checkedFrequency != 0 {
        vc.notificationTime = getTimeFromCheckedRow(row: checkedTime)
        } else {
            vc.notificationTime = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkedTime = self.alarmSetting.checkedTime
        self.checkedFrequency = self.alarmSetting.checkedFrequency

        self.checkedDaysOfWeek = Array<Int>(self.alarmSetting.checkedDaysOfWeek)
        
        
        self.tableView.selectRow(at: [0, self.checkedFrequency], animated: false, scrollPosition: UITableView.ScrollPosition.none)
        
        // 선택 회색 해제
        self.tableView.cellForRow(at: [0, self.checkedFrequency])?.selectionStyle = .none
        
        self.tableView.cellForRow(at: [0, self.checkedFrequency])?.accessoryType = .checkmark
        self.lastCheckedIndexPathInSection[0] = [0, self.checkedFrequency]
        isSectionChecked[0] = true
        
        self.tableView.cellForRow(at: [1, self.checkedTime])?.accessoryType = .checkmark
        self.lastCheckedIndexPathInSection[1] = [1, self.checkedTime]
        if self.checkedFrequency != 0 {
            isSectionChecked[1] = true
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // Todo: 탭 선택 변경 가능하게,,
        // 현재 섹션이 체크가 안되어있으면
        if !isSectionChecked[indexPath.section] {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            // 설정된 값은 prepare 함수 안에서 문자열로 변환 후 unwind되어서 넘어감.
            switch (indexPath.section) {
            case 0: // frequency section
                self.checkedFrequency = indexPath.row
                break
            case 1:
                self.checkedTime = indexPath.row
                break
            default:
                print("error")
            }
            // 체크한 row의 indexPath 정보를 section별로 저장
            lastCheckedIndexPathInSection[indexPath.section] = indexPath
            isSectionChecked[indexPath.section] = true
        } else { // 현재 섹션이 체크가 되어있으면, 기존 체크된 셀을 체크 해제
            
            // 첫 번째 섹션을 눌렀고,
            // '사용자 설정' 셀에 체크가 되어있을때
            if indexPath.section == 0 && !lastCheckedIndexPathInSection[indexPath.section].isEmpty && lastCheckedIndexPathInSection[indexPath.section].row == 2 {
                tableView.cellForRow(at: lastCheckedIndexPathInSection[indexPath.section])?.accessoryType = .disclosureIndicator
                userSelectDayLabel.text = "요일 선택"
            } else {
                tableView.cellForRow(at: lastCheckedIndexPathInSection[indexPath.section])?.accessoryType = .none
            }
            // 현재 섹션에 체크된 셀을 체크 해제하고, 현재 셀에 체크
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
            // 설정된 값은 prepare 함수 안에서 문자열로 변환 후 unwind되어서 넘어감.
            switch (indexPath.section) {
            case 0: // 빈도(요일) 설정
                self.checkedFrequency = indexPath.row
                break
            case 1: // 시간 설정
                self.checkedTime = indexPath.row
                break
            default:
                print("error")
            }
        }
        
        lastCheckedIndexPathInSection[indexPath.section] = indexPath
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
            return  getDayStringFromDaysArray(dayList: checkedDaysOfWeek)
        default:
            return "선택 되지 않음"
        }
    }

    func getDayStringFromDaysArray(dayList: [Int]) -> String {
        if dayList.isEmpty {
            return ""
        }
        let resultDayString: String = dayList.reduce("매주 ", {(prev: String, day: Int) -> String in
            var dayString: String {
                switch day {
                case 0:
                    return "월"
                case 1:
                    return "화"
                case 2:
                    return "수"
                case 3:
                    return "목"
                case 4:
                    return "금"
                case 5:
                    return "토"
                case 6:
                    return "일"
                default:
                    return ""
                }
            }
            return prev + dayString + " "
        })
        return resultDayString
    }

}
