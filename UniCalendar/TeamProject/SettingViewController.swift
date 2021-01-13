//
//  SettingViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/06.
//

import Foundation
import UIKit

extension SettingViewController: UITableViewDataSource, UITableViewDelegate{
    //section count
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as! ThemeCell
        
        cell.themeName.text = themes[indexPath.row]
        
        return cell
    }
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var label: UILabel!
    
    let sectionName: [String] = ["테마 바꿀래요🎨", "카테고리 관리🔨", "우리 앱은요🔖"]
    var themes: [String] = ["테마1☝️", "테마2✌️", "테마3✌️☝️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }


}
