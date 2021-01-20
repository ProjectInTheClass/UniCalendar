import Foundation
import RealmSwift

class API {
    static let shared = API()
    
    let realm = try! Realm()
    
    let callEventList = realm.objects(EventList.self)
}

class Category: Object {
    @objc dynamic var categoryName:String = ""
    @objc dynamic var categoryColor:Int = 0
    
    let events = List<Event>()
}

class EventList: Object {
    let events = List<Event>()

}

class Event: Object {
    @objc dynamic var eventName: String = ""
    @objc dynamic var eventDday: Date = Date.init()
    @objc dynamic var importance: Int = 0
    @objc dynamic var eventIsDone: Bool = false

    var parentCategory = LinkingObjects(fromType: Category.self, property: "events")
    var parentEventList = LinkingObjects(fromType: EventList.self, property: "events")
    let subEvents = List<SubEvent>()
}

class SubEvent: Object {
    @objc dynamic var subEventName: String = ""
    @objc dynamic var subEventIsDone: Bool = false
    
    var parentEvent = LinkingObjects(fromType: Event.self, property:"subEvents")
}


