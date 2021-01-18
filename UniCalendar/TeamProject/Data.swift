//
//  Data.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/18.
//

import Foundation

class API {
    static let shared = API()
    
   var eventInfo: EventInfo? = nil
    
    func initDatabase() {
        // User Default에서 가져오는 코드
        //self.eventInfo = EventInfo(events: [])
        
    }
    
    func saveDatabase() {
        // User Default로 저장
    }
}

struct EventInfo: Codable {
    var events:[Event]
}

struct Event: Codable {
    var category: Category
    var subEvent: [SubEvent]
    
    var eventName: String
    var eventDday: Date
    var Importance: Int
    var eventIsDone: Bool
}

struct SubEvent: Codable {
    var subEventName: String
    var subEventIsDone: Bool
}

enum Color: Int, Codable {
    case red, yellow, orange, green, blue, purple
}

struct Category: Codable {
    var categoryName: [String] = ["📓과제", "📝시험", "👥대외활동"]
    var categoryColor: Color
}
