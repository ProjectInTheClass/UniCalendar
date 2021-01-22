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
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
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
            
//            let dateComponent = DateFormatter('y)
//            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
//            let request = UNNotificationRequest(identifier: notification.id, content: notificationContent, trigger: trigger)
//            
//            UNUserNotificationCenter.current().add(request) { error in
//                guard error == nil else { return }
//                print("Scheduling notification with id: \(notification.id)")
//            }
        }
    }
}
