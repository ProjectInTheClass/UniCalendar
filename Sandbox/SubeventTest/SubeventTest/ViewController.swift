//
//  ViewController.swift
//  SubeventTest
//
//  Created by 김준경 on 2021/01/19.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    var mySubEventName = "집에 가고싶다"
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeSubEvent()
        
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

        
}


 
