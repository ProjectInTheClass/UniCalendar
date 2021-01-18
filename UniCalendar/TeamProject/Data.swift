//
//  Data.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/18.
//
//

// UserDefaults: by value
// Event / Category 함수 따로
// getX, setX

import Foundation

class API {
    static let shared = API()
    
    var eventInfo: EventInfo? = nil

    var categoryInfo: Category? = nil
    // var userDatabase = UserDefaults.standard
    
    func initDatabase() {
        // User Default에서 가져오는 코드
        // self.eventInfo = EventInfo(events: [])

        
        /*
          // set Info
          eventInfo = UserDefaults.object(forKey: "eventInfo")
          categoryInfo = UserDefaults.object(forKey: "categoryInfo")
        */

    }
    
    func saveDatabase() {
        // User Default로 저장
        
        /*
           // get Info
           let encoder = JSONEncoder()
           var encodedEventInfo = encoder.encode(eventInfo)
         
           userDatabase.set(encodedEventInfo, forKey: "eventInfo")
           userDatabase.set(encodedCategoryInfo
         
        */
    }
}

struct EventInfo: Codable {
    var events:[Event]
}
struct CategoryInfo: Codable {
    var categories: [Category]
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
    var categoryName: String
    // var categoryName: [String] = ["📓과제", "📝시험", "👥대외활동"]
    var categoryColor: Color
}
