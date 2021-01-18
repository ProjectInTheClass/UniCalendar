//
//  SettingViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/06.
//

import Foundation
import UIKit


//struct CategoryItem {
//    enum Color {
//           case red, yellow, orange, green, blue, purple
//    }
//    
//    var categoryName: String
//    var categoryColor: Color
//}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate{
    //section count
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //sections' name
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]

    }
    
    //rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){ //category section
            return items.count+1
        } else { //about app section
            return 1
        }
    }

    //add contents for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            //category seciton
            if(indexPath.row < items.count){
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
                                
                let category = items[indexPath.row]
                    
                cell.categoryName.text = category.categoryName
                
                return cell
            } else {
                //add category row
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddCategoryCell", for: indexPath) as! AddCategoryCell
                
                cell.addLabel.text = add
                cell.addLabel.textColor = UIColor.init(red: 0, green: 0, blue: 1, alpha: 1)
                
                return cell
            }
            
        } else {
            //about app section
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for:indexPath) as! AboutCell
            
            cell.aboutLabel.text = about
            
            return cell
        }
        
    }
    
    //if selected -> perform segue to move to another view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case items.count:
                self.performSegue(withIdentifier: "addCategoryModal", sender: nil)
            default:
                self.performSegue(withIdentifier: "moveToDetail", sender: nil)
                    break
            }
            
        default:
            self.performSegue(withIdentifier: "moveToAboutPage", sender: nil)
        }
    }
    
}

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionName: [String] = ["카테고리 관리🔨", "우리 앱은요🔖"]
    let about = "앱을 소개합니다👐🏻"
    let add = "카테고리 추가"
    
    var items: [CategoryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
//        for count in items {
//
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //API.shared.initDatabase()
        Category.shared.getCategoryItems(completion: { category in
            self.items = category
            self.tableView.reloadData()
        })
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        
    }

}
