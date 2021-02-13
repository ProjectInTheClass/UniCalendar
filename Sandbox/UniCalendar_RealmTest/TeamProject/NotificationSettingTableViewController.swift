//
//  NotificationSettingTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/21.
//

import UIKit

class NotificationSettingTableViewController: UITableViewController {

    var checkedFrequency: Int = 0
    // 사용자 선택
    
    @IBOutlet weak var userSelectDayLabel: UILabel!
    var userSelectDayString:String = ""
    
    // 사용자 설정 -> 선택된 요일 값을 배열로 받아옴
    var checkedDaysOfWeek: [Int] = Array<Int>()
    var checkedTime: Int = -1

    // 각 section별로, 마지막 체크된 셀의 indexPath는 무엇인가
    var lastCheckedIndexPathInSection: [IndexPath] = [IndexPath(), IndexPath()]
    var lastCheckedFrequency: Int = -1
    var lastCheckedTime: Int = -1
    
    var isSectionChecked: [Bool] = [false, false]
    var notificationSettingChanged: Bool = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        guard let vc = destView as? EventAddTableViewController else {
            return
        }
        
        //선택한 값 EventAddTableView에 indexPath로 넘겨서 저장
        vc.frequencyIndexPathRow = lastCheckedIndexPathInSection[0].row
        if lastCheckedIndexPathInSection[1].isEmpty {
            lastCheckedIndexPathInSection[1] = [1, -1]
        }
        vc.timeIndexPathRow = lastCheckedIndexPathInSection[1].row
        
        // 0 1 2
        vc.notificationFrequency = getDayFromCheckedRow(row: lastCheckedIndexPathInSection[0].row)
        
        vc.checkedFrequency = self.lastCheckedIndexPathInSection[0].row
        vc.checkedDaysOfWeek = self.checkedDaysOfWeek
        
        vc.checkedTime = self.lastCheckedIndexPathInSection[1].row
        // checkedDay가 0이면 빈도: 없음 선택이므로, 시간대도 없음
        if self.lastCheckedIndexPathInSection[0].row != 0 {
            vc.notificationTime = getTimeFromCheckedRow(row: self.lastCheckedIndexPathInSection[1].row)
        } else {
            vc.notificationTime = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if lastCheckedFrequency != -1 && lastCheckedTime != -1 {
            tableView.selectRow(at: [0, lastCheckedFrequency], animated: false, scrollPosition: .none)
            tableView.selectRow(at: [1, lastCheckedTime], animated: false, scrollPosition: .none)
            
            tableView.cellForRow(at: [0, lastCheckedFrequency])?.selectionStyle = .none
            tableView.cellForRow(at: [1, lastCheckedTime])?.selectionStyle = .none
            
            tableView.cellForRow(at: [0, lastCheckedFrequency])?.accessoryType = .checkmark
            
            if self.lastCheckedFrequency != 0 {
                tableView.cellForRow(at: [1, lastCheckedTime])?.accessoryType = .checkmark
            } else {
                tableView.cellForRow(at: [1, lastCheckedTime])?.accessoryType = .none
            }
            
            lastCheckedIndexPathInSection[0] = [0, lastCheckedFrequency]
            lastCheckedIndexPathInSection[1] = [1, lastCheckedTime]

            isSectionChecked[0] = true
            isSectionChecked[1] = true

        
            userSelectDayString = getDayStringFromDaysArray(dayList: checkedDaysOfWeek)

            if userSelectDayString == "" || lastCheckedIndexPathInSection[0].row != 2 || checkedDaysOfWeek.isEmpty == true {
                userSelectDayLabel.text = "요일 선택"
                self.tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.accessoryType = .disclosureIndicator
            } else {
                userSelectDayLabel.text = userSelectDayString
            }
            
        } else if lastCheckedFrequency == 0 || lastCheckedFrequency == -1 {
            tableView.selectRow(at: [0, 0], animated: false, scrollPosition: .none)
            //tableView.cellForRow(at: [0, 0])?.selectionStyle = .none
            if lastCheckedFrequency == 0 {
                tableView.cellForRow(at: [0, 0])?.accessoryType = .checkmark
            }
            lastCheckedIndexPathInSection[0] = [0, 0]

            isSectionChecked[0] = true
            isSectionChecked[1] = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }

    // cancel button
    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // done button
    @IBAction func goToAddEvent(_ sender: Any) {
        //isSectionChecked에 따라 저장 값 달라짐
        if isSectionChecked[1] == true { //첫 번째 섹션에서 '없음'이 아닐때 == 시간 선택이 있을 때
            lastCheckedFrequency = lastCheckedIndexPathInSection[0][1]
            lastCheckedTime = lastCheckedIndexPathInSection[1][1]
        } else { //시간 선택이 없을 때
            lastCheckedFrequency = lastCheckedIndexPathInSection[0][1]
        }
        
        
        //'없음'이 아닌데 밑에 시간을 선택하지 않았을 때 예외 처리
        if lastCheckedFrequency != 0 && lastCheckedTime == -1 {
            let alert = UIAlertController(title: "⚠️알림 시간 설정 오류⚠️", message: "시간 설정하는 걸 잊으신 건 아닌가요?😮 설정을 다시 확인해주세요!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("돌아가기", comment: "Default action"), style: .default, handler: { _ in
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else { //정상적으로 작동할때
            performSegue(withIdentifier: "unwindToAddEventFromNotification", sender: self)
        }
        self.notificationSettingChanged = true
    }
    
    @IBAction func unwindToNotificationSetting(_ unwindSegue: UIStoryboardSegue) {
        userSelectDayString = getDayStringFromDaysArray(dayList: checkedDaysOfWeek)
        if userSelectDayString == "" {
            userSelectDayLabel.text = "요일 선택"
            self.tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.accessoryType = .disclosureIndicator
        } else {
            userSelectDayLabel.text = userSelectDayString
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        
        if indexPath == [0,0] && isSectionChecked[1] == true {
            self.tableView.cellForRow(at: lastCheckedIndexPathInSection[1])?.accessoryType = .none
            isSectionChecked[1] = false
            lastCheckedIndexPathInSection[1].row = -1
        }
        
        if indexPath.section == 1 && lastCheckedIndexPathInSection[0].row == 0 {
            self.tableView.cellForRow(at: [0, 0])?.accessoryType = .none
        }
        
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
                tableView.cellForRow(at: [0,2])?.accessoryType = .disclosureIndicator
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
            return "선택되지 않음"
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
                    return "선택되지 않음"
                }
            }
            return prev + dayString + " "
        })
        return resultDayString
    }

}
