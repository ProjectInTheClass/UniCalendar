import Foundation
import RealmSwift

class API {
    static let shared = API()
    
    let realm = try! Realm()
    
    func callCategory() -> Results<Category>{
    //        let event = callEvent()
            return realm.objects(Category.self)
        }
    
    func callEvent() -> [Event] {
//        let subEvent = callSubEvent()
        let r: [Event] = realm.objects(Event.self).map { $0 }
        return r
    }
    
    func callSubEvent() -> Results<SubEvent>{
        return realm.objects(SubEvent.self)
    }
    
    func callContent() -> Results<Content>{
        return realm.objects(Content.self)
    }
    
}

class Category: Object {
    @objc dynamic var categoryName: String = ""
    @objc dynamic var categoryColor: Int = 0
    
    let eventsInCategory = List<Event>()
    
    convenience init(categoryName: String, categoryColor: Int) {
        self.init()
        self.categoryName = categoryName
        self.categoryColor = categoryColor
    }
}


class Event: Object {
    @objc dynamic var eventName: String = ""
    @objc dynamic var eventDday: Date = Date.init()
    @objc dynamic var importance: Int = 0
    @objc dynamic var eventIsDone: Bool = false

    let subEvents = List<SubEvent>()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "eventsInCategory")
    
    convenience init(eventName: String, eventDday : Date, importance : Int, eventIsDone : Bool ) {
        self.init()
        self.eventName = eventName
        self.eventDday = eventDday
        self.importance = importance
        self.eventIsDone = eventIsDone
    }

}

class SubEvent: Object {
    @objc dynamic var subEventName: String = ""
    @objc dynamic var subEventIsDone: Bool = false
    
    var parentEvent = LinkingObjects(fromType: Event.self, property:"subEvents")
    
    convenience init(subEventName: String, subEventIsDone: Bool) {
        self.init()
        self.subEventName = subEventName
        self.subEventIsDone = subEventIsDone
    }
}

class Content: Object {
    @objc dynamic var firstContent: String = ""
    @objc dynamic var secondContent: String = ""
    @objc dynamic var thirdContent: String = ""
    
    convenience init(firstContent: String, firstContent: String, firstContent: String) {
        self.init()
        self.subEventName = subEventName
        self.subEventIsDone = subEventIsDone
    }
}


