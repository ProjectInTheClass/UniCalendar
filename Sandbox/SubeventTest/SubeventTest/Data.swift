//
//  Data.swift
//  SubeventTest
//
//  Created by 김준경 on 2021/01/19.
//

import Foundation
import RealmSwift

class Event: Object {
    @objc dynamic var eventName: String = ""
    @objc dynamic var eventDday: Date = Date.init()
    @objc dynamic var importance: Int = 0
    @objc dynamic var eventIsDone: Bool = false

    let subEvents = List<SubEvent>()
}

class SubEvent: Object {
    @objc dynamic var subEventName: String = ""
    @objc dynamic var subEventIsDone: Bool = false
    
    var parentEvent = LinkingObjects(fromType: Event.self, property:"subEvents")
}

