//
//  EditColorTableViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/22.
//

import UIKit

class EditColorTableViewController: UITableViewController {
    
    var firstColorIndex: Int = 0
    var confirmedColor: Int = 0
    
    @IBAction func complete(_ sender: Any) {
        performSegue(withIdentifier: "unwindToDetail", sender: nil)
    }
    
    //'unwindToDetail'위해 prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        
        guard let vc = destView as? CategoryDetailTableViewController else {return}
        
        vc.getImageChange = self.calculateColor(color: confirmedColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool){
        //처음 view 불러왔을때 기존에 저장되어있는 색깔 선택되어 있는 상태 표현
        tableView.selectRow(at: [0,firstColorIndex], animated: true, scrollPosition: UITableView.ScrollPosition.none)
        tableView.cellForRow(at: [0,firstColorIndex])?.accessoryType = .checkmark
        confirmedColor = firstColorIndex
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    
        confirmedColor = indexPath.row
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
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
            return "category_purple"
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
