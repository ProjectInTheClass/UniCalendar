//
//  ViewController.swift
//  RealmExam
//
//  Created by 김준경 on 2021/01/18.
//

import UIKit
import RealmSwift

class Cart: Object {
    @objc dynamic var name = ""
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
    @IBOutlet weak var textField: UITextField!
    @IBAction func button(_ sender: Any) {
    }
    @IBOutlet weak var tableView: UITableView!
    
    var notificationToken : NotificationToken?
    var realm: Realm?
    var items: Results<Cart>?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (items?.count)!
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = items![indexPath.row].name
            
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        realm = tryㅆ
        
    }


}

