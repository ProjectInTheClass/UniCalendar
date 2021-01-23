//
//  EventEditTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit

class EventEditTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var showImportance: UILabel!
    @IBOutlet weak var importanceSlider: UISlider!
    
    @IBOutlet weak var settledNotificationInfoLabel: UILabel!
   
    @IBOutlet weak var deleteCell: UITableViewCell!
    
    var event = api.callNotDoneEvent()
    var category = api.callCategory()
    
    var selected: Int = 0
    
    
    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.eventName.resignFirstResponder()
        return true
    }
    
    @IBAction func ringVolumeSliderChange(_ sender: UISlider)
    {
        sender.setValue(sender.value.rounded(.down), animated: false)
        print(sender.value)
        showImportance.text = String(Int(importanceSlider.value))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToDetail"{
            let selectedEvent = event[selected]
            try? api.realm.write(){
                selectedEvent.parentCategory[0].categoryName = categoryLabel.text!
                selectedEvent.eventName = eventName.text!
                selectedEvent.eventDday = datePicker.date
                selectedEvent.importance = Int(importanceSlider.value)
            }
        }
    }
    
    @IBAction func complete(_ sender: Any) {
        performSegue(withIdentifier: "unwindToDetail", sender: nil)
    }
    
    
    func deleteEvent() {
        let selectedEvent = event[selected]
        let alert = UIAlertController(title: "⚠️일정 삭제⚠️", message: "일정을 삭제하면 되돌릴 수 없어요!🙅\n그래도 삭제하시겠어요?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("네", comment: "Default action"), style: .default, handler: { _ in
        //NSLog("The \"OK\" alert occured.")
            try? api.realm.write{
                api.realm.delete(selectedEvent)
            }
            
            self.performSegue(withIdentifier: "unwindToHomeFromEdit", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "아뇨", style: .cancel, handler: { _ in
            //NSLog("The NO alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            print("make category change")
//        } else if indexPath.row ==
        if indexPath.row == 0 && tableView.cellForRow(at: indexPath)?.textLabel?.text == "이 일정 삭제하기" {
            deleteEvent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventName.delegate = self
        print(deleteCell!)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let selectedEvent = event[selected]
        categoryLabel.text = selectedEvent.parentCategory[0].categoryName
        eventName.text = selectedEvent.eventName
        datePicker.date = selectedEvent.eventDday
        showImportance.text = String(selectedEvent.importance)
        importanceSlider.value = Float(selectedEvent.importance)
        //settledNotificationInfoLabel.text = 
    }
    
    

}
