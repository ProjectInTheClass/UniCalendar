//
//  Data.swift
//  SubeventTest
//
//  Created by 김준경 on 2021/01/19.
//

import Foundation
import RealmSwift

class API {
    static let shared = API()
    
    let realm = try! Realm()
    
    func initDatabaseEvent() {
       
    }
    
    func initDatabaseCategory() {
        
    }
    
    func saveDatabaseEvent() {
        
    }
    
    func saveDatabaseCategory() {
        
    }
}


class Category: Object {
    @objc dynamic var categoryName: String = ""
    @objc dynamic var categoryColor: Int = 0
    
    let eventsInCategory = List<Event>()
}

class Event: Object {
    @objc dynamic var eventName: String = ""
    @objc dynamic var eventDday: Date = Date.init()
    @objc dynamic var importance: Int = 0
    @objc dynamic var eventIsDone: Bool = false

    let subEvents = List<SubEvent>()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "eventsInCategory")
}

class SubEvent: Object {
    @objc dynamic var subEventName: String = ""
    @objc dynamic var subEventIsDone: Bool = false
    
    var parentEvent = LinkingObjects(fromType: Event.self, property:"subEvents")
}

class Content: Object {
    @objc dynamic var firstContent: String = ""
    @objc dynamic var secondContent: String = ""
    @objc dynamic var thirdContent: String = ""
}


