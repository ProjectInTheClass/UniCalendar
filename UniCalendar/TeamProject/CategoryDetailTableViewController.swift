//
//  CategoryDetailTableViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/16.
//

import UIKit
import RealmSwift

class CategoryDetailTableViewController: UITableViewController {
    
    var category = api.callCategory()
    var event = api.callEvent()
    var getImageChange: String = ""
    
    var categoryIndex: Int = 0
   
    @IBOutlet weak var categoryNameTextField: UITextField!
    @IBOutlet weak var categoryColor: UIImageView!
    
    //'완료' action함수
    @IBAction func completeModal(_ sender: Any) {
        //realm에 write -> 수정
        try? api.realm.write(){
            category[categoryIndex].categoryName = categoryNameTextField.text!
            category[categoryIndex].categoryColor = calculateColorInt(color: getImageChange)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //EditColorTableView에서 Detail로 unwind할 수 있게 해주는 함수
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        categoryColor.image = UIImage(named: getImageChange)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TextField + Color설정
        getImageChange = calculateColor(color: category[categoryIndex].categoryColor)
        categoryNameTextField.text = category[categoryIndex].categoryName
        categoryColor.image = UIImage(named: calculateColor(color: category[categoryIndex].categoryColor))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        
        if indexPath.row == 1 {
            //1번째 row선택시 EditColorTableView로 넘어감
            performSegue(withIdentifier: "windToEditColor", sender: category[categoryIndex].categoryColor)
        } else if indexPath.row == 2 {
            //alert메세지 생성
            let alert = UIAlertController(title: "⚠️카테고리 삭제⚠️", message: "카테고리를 삭제하면 카테고리에 포함되어 있는 👉🏻모든👈🏻 목표가 사라져요!\n그래도 삭제하시나요?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("네", comment: "Default action"), style: .default, handler: { _ in
            //NSLog("The \"OK\" alert occured.")
                try? api.realm.write{
                    api.realm.delete(self.category[self.categoryIndex].eventsInCategory)
                    api.realm.delete(self.category[self.categoryIndex])
                }
                
                //self.category = api.callCategory()
                //self.event = api.callEvent()
                //self.category[categoryIndex].eventsInCategory = api.callEvent()
                
                self.performSegue(withIdentifier: "unwindToSettingFromDetail", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: "아뇨", style: .cancel, handler: { _ in
                //NSLog("The NO alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
//
        }
    }
    
    //unwindToSettingFromDetail 위해 prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        category = api.callCategory()
        event = api.callEvent()
        
        guard let navigation = segue.destination as? UINavigationController else {return}
        
        guard let detail = navigation.viewControllers[0] as? EditColorTableViewController else { return }
        
        guard let colorIndexPath = sender as? Int else {return}
        
        detail.firstColorIndex = colorIndexPath

    }

    
    func calculateColor(color: Int) -> String{
        switch color {
        case 0:
            return "category_purple"
        case 1:
            return "category_blue"
        case 2:
            return "category_red"
        case 3:
            return "category_yellow"
        case 4:
            return "category_green"
        case 5:
            return "category_orange"
        default:
            return ""
        }
    }
    
    func calculateColorInt(color: String) -> Int{
        switch color{
        case "category_purple":
            return 0
        case "category_blue":
            return 1
        case "category_red":
            return 2
        case "category_yellow":
            return 3
        case "category_green":
            return 4
        case "category_orange":
            return 5
        default:
            return 0
        }
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
