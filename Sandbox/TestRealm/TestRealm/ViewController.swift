//
//  ViewController.swift
//  TestRealm
//
//  Created by Nayeon Kim on 2021/01/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    //    func getDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let documentsDirectory = paths[0]
//        return documentsDirectory
//    }
    let realm = try! Realm()
    
    var events : Results<EventInfo>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        loadEventInfo()
        
    }

    func loadEventInfo() {
        events = realm.objects(EventInfo.self)
        print(events.self!)
    }
}

