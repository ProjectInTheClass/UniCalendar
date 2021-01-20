//
//  ViewController.swift
//  UserNotificationTest
//
//  Created by KM on 2021/01/19.
//

import UIKit
import UserNotifications

// Content / Trigger / Request

class ViewController: UIViewController {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNotificationCenter.delegate = self
        
        // 알림 권한 허용
        requestNotificationAuthorization()
        
        // 테스트용 Date 3개
        // Todo: 연월일시분 하나하나 입력 없이 DB에 저장된 Date 형식을 바로 쓸 수 있게
        let dateComponents: [DateComponents] = [
            DateComponents(year:2021, month: 1, day: 20, hour: 16, minute: 12, second: 0)
        ]
        
        // 알림 등록
        for dateComponent in dateComponents {
            addNotification(dateComponent: dateComponent)
        }
    }

    // 알림 권한 요청
    func requestNotificationAuthorization() {
        
        // 필요한 동작
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    // content setting
    func addNotification(dateComponent: DateComponents) {
        // 알림 여러개 등록하려면 그때그때 identifier 만들어줘야함(아마도?)
        let uuidString = UUID().uuidString
        // 알림 내용 객체
        let notificationContent = UNMutableNotificationContent()
        
        // 캘린더(날짜)기반으로 등록할것
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

        notificationContent.title = "D-10 기말고사 시험"
        notificationContent.body = "이제 일정을 시작할 때가 되었어요😅!\n아직 일정 중 ~%만 진행된 상태에요📚\n기합 넣고 시작해봐요 화이팅!💪🏻"
        
        
        // 등록 요청하려는 알림 객체
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        
        
        // 위에서 만든 request로 알림 등록
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }

}
// 알림을 받고 난 후?
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}

