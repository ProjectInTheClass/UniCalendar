//
//  EventAddTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

let api = API.shared

class EventAddTableViewController: UITableViewController {

    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
   

    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func completeModal(_ sender: Any) {
        // TODO
        // Add New event to EventList
        save()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func save() {

        let d = self.dateFormatter.date(from: "2020-01-28")
        
        let newEvent = Event(eventName: "알고리즘과제", eventDday: d!, importance: 3, eventIsDone: true)

        let category = Category(categoryName: "과제1", categoryColor: 0)
        category.eventsInCategory.append(newEvent)
                
        
        try! api.realm.write{
            api.realm.add([category])
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
}
