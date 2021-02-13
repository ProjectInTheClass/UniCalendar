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
        Thread.sleep(forTimeInterval: 1.0)
                
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
        
        
        // For Notification
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        func isAppAlreadyLaunchedOnce() -> Bool {
            let defaults = UserDefaults.standard
            if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
                print("App already launched")
                return true
            } else {
                defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
                print("App launched first time")
                return false
            }
        }
        
        if isAppAlreadyLaunchedOnce() == false {
            let hwCategory = Category(categoryName: "📓과제", categoryColor: 0)
            let examCategory = Category(categoryName: "📝시험", categoryColor: 2)
            let activityCategory = Category(categoryName: "👥대외활동", categoryColor: 1)
            
            try! api.realm.write(){
                api.realm.add(hwCategory)
                api.realm.add(examCategory)
                api.realm.add(activityCategory)
            }
            
            
            let defaultEventOne = Event.init(eventName: "새로운 목표✔️를", eventDday: Date.init(), importance: 1, eventIsDone: false, eventIsPassed: false, pushAlarmSetting: PushAlarmSetting())
            let defaultEventTwo = Event.init(eventName: "추가하고📝", eventDday: Date.init(), importance: 2, eventIsDone: false, eventIsPassed: false, pushAlarmSetting: PushAlarmSetting())
            let defaultEventThree = Event.init(eventName: "완료해보세요!💯", eventDday: Date.init(), importance: 3, eventIsDone: false, eventIsPassed: false, pushAlarmSetting: PushAlarmSetting())
            
            let defaultSubEventSentence: [String] = ["오른쪽 상단의 👉🏻수정👈🏻 버튼으로 이벤트를 자유자재로 편집✂️할 수 있어요", "세부 목표를 왼쪽으로 스와이프⬅️하면 삭제할 수 있어요!" , "세부 목표가 없어도 하단의 완료하기 버튼👇🏻을 누르면 목표를 완료할 수 있어요"]
            
            let firstSubEvent: [SubEvent] = [SubEvent.init(subEventName: defaultSubEventSentence[0], subEventIsDone: false), SubEvent.init(subEventName: defaultSubEventSentence[1], subEventIsDone: false), SubEvent.init(subEventName: defaultSubEventSentence[2], subEventIsDone: false)]
            
            let secondSubEvent: [SubEvent] = [SubEvent.init(subEventName: defaultSubEventSentence[0], subEventIsDone: false), SubEvent.init(subEventName: defaultSubEventSentence[1], subEventIsDone: false), SubEvent.init(subEventName: defaultSubEventSentence[2], subEventIsDone: false)]
            
            let thirdSubEvent: [SubEvent] = [SubEvent.init(subEventName: defaultSubEventSentence[0], subEventIsDone: false), SubEvent.init(subEventName: defaultSubEventSentence[1], subEventIsDone: false), SubEvent.init(subEventName: defaultSubEventSentence[2], subEventIsDone: false)]
            
            
            try! api.realm.write(){
                
                api.realm.add(defaultEventOne)
                api.realm.add(defaultEventTwo)
                api.realm.add(defaultEventThree)
                
                api.realm.add(firstSubEvent)
                api.realm.add(secondSubEvent)
                api.realm.add(thirdSubEvent)
                
                for element in firstSubEvent {
                    defaultEventOne.subEvents.append(element)
                }
                
                for element in secondSubEvent {
                    defaultEventTwo.subEvents.append(element)
                }
                
                for element in thirdSubEvent {
                    defaultEventThree.subEvents.append(element)
                }
                
                hwCategory.eventsInCategory.append(defaultEventOne)
                examCategory.eventsInCategory.append(defaultEventTwo)
                activityCategory.eventsInCategory.append(defaultEventThree)
            }

            let defaultBadge = Badge.init(badgeImageString: "처음_깔았을_때")
            
            
            try! api.realm.write(){
                api.realm.add(defaultBadge)
            }
        }
            
        
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


