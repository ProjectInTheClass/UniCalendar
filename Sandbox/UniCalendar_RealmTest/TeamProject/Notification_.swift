//
//  Notification.swift
//  TeamProject
//
//  Created by KM on 2021/01/22.
//

// ------------------------------------------------------------

import Foundation
import UserNotifications

struct Notification_ {
    var id: String
    var title: String
    var content : String
    var dateString: String
}

class LocalNotificationManager {
    var notifications = [Notification_]()
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
        }
    }
    
    func addNotification(title: String, content: String, dateString: String) -> Void {
        notifications.append(Notification_(id: UUID().uuidString, title: title, content: content, dateString: dateString))
    }
    
    func scheduleNotifications() -> Void {
        for notification in notifications {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = notification.title
            notificationContent.body = notification.content
            
            // 날짜 객체
            let dateComponent = DateComponents(year: 2021, month: 1, hour: 9, weekday: 3)
            // 알림 속성(시간, 위치 등)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
            // 위 데이터를 넣어서 알림 요청
            let request = UNNotificationRequest(identifier: notification.id,
                                                content: notificationContent,
                                                trigger: trigger)
            // 알림 등록
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
    }
    // 버그: 세부 목표0인 이벤트에 들어갔다 나오면 100%로 완료됨
    // 예상: isDone: 0, count: 0 => 완료다! 싶은건가
    // 그치만 세부목표 추가는 가능
    func printCountOfNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
            if requests.count < 1 {
                print("emtpy requests")
            } else {
                print("You Have \(requests.count) pending notifications.")
                for r in requests {
                    print("-title: \(r.content.title)")
                    print("-body: \(r.content.body): ")
                }
            }
        })
    }
}
