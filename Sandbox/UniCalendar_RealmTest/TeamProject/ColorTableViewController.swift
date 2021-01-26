////
////  ColorTableViewController.swift
////  TeamProject
////
////  Created by Nayeon Kim on 2021/01/16.
////
//
import UIKit

class ColorTableViewController: UITableViewController {

    var confirmedColor: Int = 0
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    //goTo 위해 prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination
        
        guard let vc = destView as? ModalTableViewController else {
            return
        }
        
        //ModalTableViewController의 getImageChange 값 변경
        vc.getImageChange = self.calculateColor(color: confirmedColor)
    }
    
    //'완료' 버튼 action함수
    @IBAction func goTo(_ sender: Any) {
        performSegue(withIdentifier: "unwindToAddModal", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //show checkmark for selected row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        confirmedColor = indexPath.row
    }
    
    //deselect the row as we only need SINGLE checkmark
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
            return ""
        }
    }
    
    

}


