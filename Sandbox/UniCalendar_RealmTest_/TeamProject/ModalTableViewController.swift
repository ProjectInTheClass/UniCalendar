////
////  ModalTableViewController.swift
////  TeamProject
////
////  Created by Nayeon Kim on 2021/01/15.
////
//
//import UIKit
//
//
//class ModalTableViewController: UITableViewController, UITextFieldDelegate {
//    
//    var getImageChange: String = "category_purple"
//    
//    @IBOutlet weak var showColorImage: UIImageView!
//    @IBOutlet weak var nameTextField: UITextField!
//    
//    @IBAction func unwind (segue: UIStoryboardSegue) {
//        print(getImageChange)
//        showColorImage.image = UIImage(named: getImageChange)
//    }
//    
//    @IBAction func completeModal(_ sender: Any) {
//        //Category.shared.categories.append(CategoryItem(categoryName: nameTextField.text!, categoryColor: getEnumColor(color: getImageChange)))
//        items.append(CategoryItem(categoryName: nameTextField.text!, categoryColor: getEnumColor(color: getImageChange)))
//        
//        self.dismiss(animated: true, completion: nil)
//        
//    }
//    
//    @IBAction func cancelModal(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    override func viewWillAppear(_ animated: Bool){
//        self.nameTextField.becomeFirstResponder()
//        //print("Category Add Modal appeared")
//    }
//    
//    var items: [CategoryItem] = []
//    
//    
//    override func viewDidAppear(_ animated: Bool) {
//        Category.shared.getCategoryItems(completion: {
//            category in
//            self.items = category
//        })
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        nameTextField.delegate = self
//    }
//    
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.nameTextField.resignFirstResponder()
//        //self.dismiss(animated: true, completion: nil)
//        return true
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 1 {
//            self.performSegue(withIdentifier: "chooseColor", sender: nil)
//        }
//    }
//    
//    func getEnumColor(color: String) -> CategoryItem.Color{
//        switch color{
//        case "category_purple":
//            return CategoryItem.Color.purple
//        case "category_blue":
//            return CategoryItem.Color.blue
//        case "category_red":
//            return CategoryItem.Color.red
//        case "category_yellow":
//            return CategoryItem.Color.yellow
//        case "category_orange":
//            return CategoryItem.Color.orange
//        case "category_green":
//            return CategoryItem.Color.green
//        default:
//            return CategoryItem.Color.purple
//        }
//    }
//    
//    
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        let colorCell = segue.destination as!
////    }
////
////    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
////        if textField.text != "" {return true}
////        else {
////            textField.placeholder = "카테고리 이름"
////            return false
////        }
////    }
////
////    func textFieldDidEndEditing(_ textField: UITextField) {
////        textField.text = ""
////    }
//    
//    
//
//    // MARK: - Table view data source
//
////    override func numberOfSections(in tableView: UITableView) -> Int {
////        // #warning Incomplete implementation, return the number of sections
////        return 0
////    }
////
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        // #warning Incomplete implementation, return the number of rows
////        return 2
////    }
//
//    /*
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    */
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}


import UIKit
import RealmSwift

class ModalTableViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
