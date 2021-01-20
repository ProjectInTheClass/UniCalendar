//
//  EventAddTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

class EventAddTableViewController: UITableViewController {

    @IBOutlet weak var eventNameField: UITextField!
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.eventNameField.becomeFirstResponder()
        //print("Category Add Modal appeared")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.eventNameField.resignFirstResponder()
        //self.dismiss(animated: true, completion: nil)
        return true
    }
    
}
