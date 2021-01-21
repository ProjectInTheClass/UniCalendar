//
//  EventAddTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

class EventAddTableViewController: UITableViewController {

    // 알림 시간 설정값을 받아오는 변수
    // 나중에 date로 교체?
    var getNotificationFrequency: String = "매주 월요일(test)"
    var getNotificationTime: Int = 0
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var notificationFrequency: UILabel!
    @IBOutlet weak var notificationTime: UILabel!
    
//    @IBAction func unwind (segue: UIStoryboardSegue) {
//        print(getImageChange)
//        showColorImage.image = UIImage(named: getImageChange)
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            self.performSegue(withIdentifier: "getNotificationSetting", sender: nil)
        }
    }
    
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
        self.notificationTime.text = "\(self.getNotificationTime)"
        self.eventNameField.becomeFirstResponder()
        //print("Category Add Modal appeared")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.eventNameField.resignFirstResponder()
        //self.dismiss(animated: true, completion: nil)
        return true
    }
    
}
