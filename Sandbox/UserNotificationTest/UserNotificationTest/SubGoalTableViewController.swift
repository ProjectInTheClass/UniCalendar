//
//  SubGoalTableViewController.swift
//  UserNotificationTest
//
//  Created by KM on 2021/01/20.
//

import UIKit

class SubGoalTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let subGoals: [String] = [
    "1차 검토", "2차 검토", "마무리하기","1차 검토", "2차 검토", "마무리하기","1차 검토", "2차 검토", "마무리하기","1차 검토", "2차 검토", "마무리하기","1차 검토", "2차 검토", "마무리하기","1차 검토", "2차 검토", "마무리하기","1차 검토", "2차 검토", "마무리하기"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subGoals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubGoalCell", for: indexPath)
        cell.textLabel?.text = subGoals[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }


}
