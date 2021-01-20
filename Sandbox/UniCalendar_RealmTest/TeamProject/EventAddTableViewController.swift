//
//  EventAddTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

class EventAddTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeModal(_ sender: Any) {
        // TODO
        // Add New event to EventList
        let myEvent = Event()
        //let mySubEvent = SubEvent()
        
        let eventName = "checkcheck"
        let eventDday = Date.init()
        let importance = 3
        let eventIsDone = false
        
        myEvent.eventName = eventName
        myEvent.eventDday = eventDday
        myEvent.importance = importance
        myEvent.eventIsDone = eventIsDone
        
       
        
        try! API.shared.realm.write {
            API.shared.realm.add(myEvent)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
