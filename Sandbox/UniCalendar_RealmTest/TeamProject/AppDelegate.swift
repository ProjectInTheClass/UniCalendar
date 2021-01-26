//
//  AppDelegate.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2020/12/31.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var events = api.callEvent()
        //var count: Int = 0
        var change: Int = 0
        
//        let day = DateFormatter()
//        day.dateFormat = "yyyy-mm-dd"
        
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
        
        if events.isEmpty == false {
            while change < events.count {
                let eventDday = Calendar.current.dateComponents([.year, .month, .day], from: events[change].eventDday)
                
                if (eventDday.year! < today.year!) || (eventDday.year! <= today.year! && eventDday.month! < today.month!) || (eventDday.year! <= today.year! && eventDday.month! <= today.month! && eventDday.day! < today.day!) {
                    try! api.realm.write(){
                        events[change].eventIsPassed = true
                    }
                }
                change += 1
            }
        }
        
        events = api.callEvent()
        
        var defaultCategory = api.callCategory()
        
        if defaultCategory.isEmpty == true {
            let hwCategory = Category(categoryName: "📓과제", categoryColor: 0)
            let examCategory = Category(categoryName: "📝시험", categoryColor: 2)
            let activityCategory = Category(categoryName: "👥대외활동", categoryColor: 1)
            
            try! api.realm.write(){
                api.realm.add(hwCategory)
                api.realm.add(examCategory)
                api.realm.add(activityCategory)
            }
            
            defaultCategory = api.callCategory()
        }
        
        
        // For Notification
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


