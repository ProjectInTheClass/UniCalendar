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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeEvent()
        //makeSubEvent()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
//        getDocumentsDirectory()
        
    }
//    func getDocumentsDirectory() -> URL {
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            let documentsDirectory = paths[0]
//            return documentsDirectory
//        }
    
    
   func makeSubEvent(){
       let mySubEvent = SubEvent()
         
       mySubEvent.subEventName = mySubEventName
       
        print(mySubEvent)
   }
    
    func makeEvent() {
        let myEvent = Event()
        
        myEvent.eventName = eventName
        myEvent.eventDday = eventDday
        myEvent.eventIsDone = eventIsDone
        myEvent.importance = importance
        
        makeSubEvent()
        print(myEvent)
    }

        
}


 
