import Foundation
import RealmSwift

class API {
    static let shared = API()
    
    let realm = try! Realm()
    
    func callCategory() -> [Category]{
        let r: [Category] = realm.objects(Category.self).map { $0 }
        return r
    }
    
    func callEvent() -> [Event] {
        let r: [Event] = realm.objects(Event.self).map { $0 }
        return r
    }
    
    func callNotDoneEvent() -> [Event] {
        let r: [Event] = realm.objects(Event.self).filter("eventIsDone = false").sorted(byKeyPath: "eventDday").map { $0 }
        return r
    }
    
    func callDoneEvent() -> [Event] {
        let r: [Event] = realm.objects(Event.self).filter("eventIsDone = true").sorted(byKeyPath: "eventDday", ascending: false).map { $0 }
        return r
    }
    
    func callSubEvent() -> [SubEvent]{
        let r: [SubEvent] = realm.objects(SubEvent.self).map { $0 }
        return r
    }
    
    func callContent() -> [Content]{
        let r: [Content] = realm.objects(Content.self).map { $0 }
        return r
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
    
    convenience init(eventName: String, eventDday : Date, importance : Int, eventIsDone : Bool) {
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
    @objc dynamic var begin: String = ""
    @objc dynamic var earlyMiddle: String = ""
    @objc dynamic var lateMiddle: String = ""
    @objc dynamic var end: String = ""
    
    convenience init(begin: String, earlyMiddle: String, lateMiddle: String, end: String) {
        self.init()
        self.begin = begin
        self.earlyMiddle = earlyMiddle
        self.end = end
    }
}
