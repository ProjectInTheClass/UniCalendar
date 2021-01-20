////
////  ColorTableViewController.swift
////  TeamProject
////
////  Created by Nayeon Kim on 2021/01/16.
////
//
//import UIKit
//
//class ColorTableViewController: UITableViewController {
//
//    var confirmedColor: Int = 0
//    //var colors : [CategoryItem.Color]
//    
//    @IBOutlet weak var doneButton: UIBarButtonItem!
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destView = segue.destination
//        
//        guard let vc = destView as? ModalTableViewController else {
//            return
//        }
//        
//        vc.getImageChange = self.calculateColor(color: confirmedColor)
//    }
//    
//    
//    @IBAction func goTo(_ sender: Any) {
//        performSegue(withIdentifier: "unwindToAddModal", sender: self)
//    }
//    
////    @IBAction func completeColorModal(_ sender: UIBarButtonItem) {
////
////        guard let backToAddModal = self.storyboard?.instantiateViewController(identifier: "AddCategory") as? ModalTableViewController else {
////            return
////        }
////        backToAddModal.getImageChange = calculateColor(color: confirmedColor)
////
////
////        self.dismiss(animated: true, completion: nil)
////        self.present(backToAddModal, animated: true)
////    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        print("Color Modal disappeared")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //self.updateCompleteButton()
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//    
//    //show checkmark for selected row
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
//        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        
//        confirmedColor = indexPath.row
//        //print(confirmedColor)
//    }
//    
//    //deselect the row as we only need SINGLE checkmark
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print(indexPath)
//        tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
//    
//    func calculateColor(color: Int) -> String{
//        switch color {
//        case 0:
//            return "category_purple"
//        case 1:
//            return "category_blue"
//        case 2:
//            return "category_red"
//        case 3:
//            return "category_yellow"
//        case 4:
//            return "category_green"
//        case 5:
//            return "category_orange"
//        default:
//            return ""
//        }
//    }
//    
//    func updateCompleteButton() {
//        
//    }
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
////        return 0
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

class ColorTableViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
