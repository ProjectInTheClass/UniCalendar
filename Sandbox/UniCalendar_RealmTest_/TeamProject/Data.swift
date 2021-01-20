import Foundation
import RealmSwift

class API {
    let realm = try! Realm()
    let category = Category()
    let eventList = EventList()
//    let category = realm.objects(EventList.self)
//         let eventList = realm.objects(EventList.self)
//         let event = realm.objects(EventList.self)
//         let subEvent = realm.objects(EventList.self)
    let event = Event()
    let subEvent = SubEvent()
//    let calEventList = realm.objects(EventList.self)
    
    func makeCategory(_ name:String,_ color: Int) -> Category {
        let category = Category()
        category.categoryName = name
        category.categoryColor = color
        
        return category
    }
    
    func makeEvent(_ name:String,_ Dday: Date,_ important:Int,_ isDone:Bool) -> Event {
        let event = Event()
        event.eventName = name
        event.eventDday = Dday
        event.importance = important
        event.eventIsDone = isDone
        
        return event
    }
    
    func makeSubEvent(_ name:String,_ isDone: Int) -> Category {
        let subEvent = SubEvent()
        subEvent.
        
        return subEvent
    }
    
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


