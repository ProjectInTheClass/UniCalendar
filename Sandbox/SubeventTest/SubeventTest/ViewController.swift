//
//  ViewController.swift
//  SubeventTest
//
//  Created by 김준경 on 2021/01/19.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
//    eventName: String = ""
//    @objc dynamic var eventDday: Date = Date.init()
//    @objc dynamic var importance: Int = 0
//    @objc dynamic var eventIsDone: Bool = false
    var eventName = "알고리즘"
    var eventDday = Date.init()
    var eventIsDone = false
    var mySubEventName = "집에 가고싶다"
    var importance = 3
    
    let realm = try! Realm()
    let myEvent = Event()
    let mySubEvent = SubEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeEvent()
        //makeSubEvent()
        let savedData = realm.objects(Event.self)
        
        realm.beginWrite()
        realm.add(myEvent)
        realm.add(mySubEvent)
        //realm.delete(realm.objects(Event.self))
        //realm.delete(realm.objects(SubEvent.self))
        try? realm.commitWrite()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
//        getDocumentsDirectory()
        
    }
//    func getDocumentsDirectory() -> URL {
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            let documentsDirectory = paths[0]
//            return documentsDirectory
//        }
    
    
   func makeSubEvent(){
         
       mySubEvent.subEventName = mySubEventName
       
        print(mySubEvent)
   }
    
    func makeEvent() {
        
        myEvent.eventName = eventName
        myEvent.eventDday = eventDday
        myEvent.eventIsDone = eventIsDone
        myEvent.importance = importance
        
        makeSubEvent()
        print(myEvent)
    }

        
}


 
