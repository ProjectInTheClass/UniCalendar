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
    
    func callNotPassedEvent() -> [Event] {
        let r: [Event] = realm.objects(Event.self).filter("eventIsPassed = false").sorted(byKeyPath: "eventDday").map { $0 }
        return r
    }
    
    func callPassedEvent() -> [Event] {
        let r: [Event] = realm.objects(Event.self).filter("eventIsPassed = true").sorted(byKeyPath: "eventDday", ascending: false).map { $0 }
        return r
    }
    
    func callSubEvent() -> [SubEvent]{
        let r: [SubEvent] = realm.objects(SubEvent.self).map { $0 }
        return r
    }
    
    func callPushAlarm() -> [PushAlarm] {
        let r: [PushAlarm] = realm.objects(PushAlarm.self).map { $0 }
        return r
    }
    
    func callPushAlarmSetting() -> [PushAlarmSetting] {
        let r: [PushAlarmSetting] = realm.objects(PushAlarmSetting.self).map { $0 }
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
    @objc dynamic var eventIsPassed: Bool = false
    @objc dynamic var pushAlarmSetting: PushAlarmSetting?
    
    let subEvents = List<SubEvent>()
    let pushAlarmID = List<PushAlarm>()
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "eventsInCategory")
    
    convenience init(eventName: String, eventDday : Date, importance : Int, eventIsDone : Bool, eventIsPassed : Bool, pushAlarmSetting: PushAlarmSetting) {
        self.init()
        self.eventName = eventName
        self.eventDday = eventDday
        self.importance = importance
        self.eventIsDone = eventIsDone
        self.eventIsPassed = eventIsPassed
        self.pushAlarmSetting = pushAlarmSetting
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

class PushAlarm: Object {
    @objc dynamic var id: String = ""
    
    var parentEvent = LinkingObjects(fromType: Event.self, property: "pushAlarmID")
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}

class PushAlarmSetting: Object {
    @objc dynamic var checkedTime: Int = 0
    @objc dynamic var checkedFrequency: Int = 0
    
    var parentEvent = LinkingObjects(fromType: Event.self, property: "pushAlarmSetting")
    
    let checkedDaysOfWeek = List<Int>()
    
    convenience init(checkedTime: Int, checkedFrequency: Int, checkedDaysOfWeek: [Int]) {
        self.init()
        self.checkedTime = checkedTime
        self.checkedFrequency = checkedFrequency
        for checkedDay in checkedDaysOfWeek {
            self.checkedDaysOfWeek.append(checkedDay)
        }
    }
}
