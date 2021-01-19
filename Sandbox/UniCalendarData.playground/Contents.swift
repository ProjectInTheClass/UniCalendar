import UIKit

class API {
    static let shared = API()
    
    var eventInfo: EventInfo? = nil
    
    func initDatabase() {
        // User Default에서 가져오는 코드
        self.eventInfo = EventInfo(events: [])
    }
    
    func saveDatabase() {
        // User Default로 저장
    }
}

struct EventInfo: Codable {
//    var eventID: EventID
    var events: [Event]
}
//
//struct EventID: Codable{
//    var eventID: [String] = ["ID001", "ID002", "ID003", "ID004", "ID005", "ID006"]
//
//}

enum Color: Int, Codable {
    case red, blue, green, yellow, orange, purple
}

struct Event: Codable {
    var category: Category
    var smallEvents: [SmallEvent]
}

//struct CategoryID: Codable {
//
//}

struct SmallEvent: Codable {
    
}

struct Category: Codable {
    var categoryName : [String : String] = ["과제" : "C001", "시험" : "C002", "대외활동": "C003"]
    var categoryColor: Color
}

