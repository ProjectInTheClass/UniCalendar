//
//  Notification.swift
//  TeamProject
//
//  Created by KM on 2021/01/22.
//

// Dateformatter Example text ------------------------------
func makeNotificationDateComponent () {
    var eventDates = [Date]()
    let events: [Event] = api.callEvent()

    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    for event in events {
        print(event)
        let day = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!
        eventDates.append(day)
    }
}

// ------------------------------------------------------------

import Foundation
import UserNotifications

struct Notification {
    var id: String
    var title: String
    var content : String
    var dateString: String
}

class LocalNotificationManager {
    var notifications = [Notification]()
    
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
        notifications.append(Notification(id: UUID().uuidString, title: title, content: content, dateString: dateString))
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
    
    func getCountOfPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
            if requests.count < 1 {
                print("emtpy requests")
                
            } else {
                print("You Have \(requests.count) pending notifications.")
                for request in requests {
                    print(request.content.title)
                }
            }
        })
    }
}
