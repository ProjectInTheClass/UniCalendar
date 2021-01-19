//
//  ViewController.swift
//  TestRealm
//
//  Created by Nayeon Kim on 2021/01/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    //@IBOutlet weak var textLabel: UILabel!
    //    func getDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }
    let realm = try! Realm()
    
    //var events : Results<EventInfo>?
    var realmOnDisc: Realm? {
            let url = Realm.Configuration.defaultConfiguration.fileURL
            let objectTypes = [Event.self, EventInfo.self, SubEvent.self, Category.self, CategoryInfo.self]
            let config = Realm.Configuration(fileURL: url,
                                             deleteRealmIfMigrationNeeded:true,
                                             objectTypes: objectTypes)

            do {
                let realm = try Realm(configuration: config)
                return realm
            } catch let error {
                //log.error("\(error)")
                return nil
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm)
        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //loadEventInfo()
        
    }

//    func loadEventInfo() {
//        events = realm.objects(EventInfo.self)
//        print(events.self!)
//    }
}

