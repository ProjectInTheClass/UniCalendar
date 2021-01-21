//
//  NotificationSettingTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/21.
//

import UIKit

class NotificationSettingTableViewController: UITableViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var checkedTime: Int = 0
    
    @IBAction func doneButtonAction(_ sender: Any) {
        print("NotiSetting / doneButton")
        performSegue(withIdentifier: "fromNotificationSetting", sender: self)
        print("NotiSetting/ performSegue")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        print("before return")
        guard let vc = destView as? EventAddTableViewController else {
            return
        }
        
        vc.getNotificationTime = getTimeFromCheckedTime(time: checkedTime)
        print("CheckedTime: \(checkedTime)")
        
    }
    
    func getTimeFromCheckedTime(time: Int) -> Int {
        switch time {
        case 0:
            return 6
        case 1:
            return 9
        case 2:
            return 12
        case 3:
            return 15
        case 4:
            return 18
        case 5:
            return 21
        default:
            return 0
        }
    }
    
    // MARK: - Table view data source

    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        checkedTime = indexPath.row
    }
    
    //deselect the row as we only need SINGLE checkmark
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
