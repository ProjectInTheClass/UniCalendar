//
//  EventAddTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

let api = API.shared

class EventAddTableViewController: UITableViewController {
    
    var categoryString: String = ""
    
    var notificationFrequency: String = ""
    var notificationTime: String = ""
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var settledNotificationInfoLabel: UILabel!
    
    var event = api.callEvent()
    
    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        // print("seg: \(seg.identifier)")
        switch seg.identifier {
        case "unwindToAddEventFromCategory":
            categoryLabel.text = categoryString
            break
        case "unwindToAddEventFromNotification":
            settledNotificationInfoLabel.text = "\(notificationFrequency) \(notificationTime)"
            break
        default:
            break
        }
    }
    


    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func completeModal(_ sender: Any) {
        // TODO
        // Add New event to EventList
        save()
        event = api.callEvent()
        //self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwindToHome", sender: (Any).self)
    }
    
    
    func save() {

        let d = self.dateFormatter.date(from: "2021-01-28")
        
        let newEvent = Event(eventName: "알고리즘과제", eventDday: d!, importance: 3, eventIsDone: true)

        //let category = Category(categoryName: "과제1", categoryColor: 0)
        //category.eventsInCategory.append(newEvent)
                
        
        try! api.realm.write{
            api.realm.add([newEvent])
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
}
