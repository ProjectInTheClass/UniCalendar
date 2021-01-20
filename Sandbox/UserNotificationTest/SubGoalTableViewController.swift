//
//  SubGoalTableViewController.swift
//  UserNotificationTest
//
//  Created by KM on 2021/01/20.
//

import UIKit

class SubGoalTableViewController: UITableViewController {
    
    @IBOutlet var subGoalTableView: UITableView!
    
    let subGoals: [String] = ["소목표1","소목표2","소목표3","소목표4","소목표5","소목표6","소목표7","소목표8","소목표9","소목표10","소목표11","소목표12","소목표13","소목표14"]
    override func viewDidLoad() {
        super.viewDidLoad()
        subGoalTableView.dataSource = self
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subGoals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subGoalTableView.dequeueReusableCell(withIdentifier: "SubGoalCell", for: indexPath)

        cell.textLabel?.text = subGoals[indexPath.row]
        
        return cell
    }


}
