////
////  ModalTableViewController.swift
////  TeamProject
////
////  Created by Nayeon Kim on 2021/01/15.
////
//
import UIKit
import RealmSwift

class ModalTableViewController: UITableViewController, UITextFieldDelegate {
    
    var category: [Category] = api.callCategory()
    
    var getImageChange: String = "category_purple"
    //이미지 파일 변경 위해 String타입 지정
    
    @IBOutlet weak var showColorImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var completeButton: UIBarButtonItem!
    
    //ModalTableViewController로 unwind하는 함수
    @IBAction func unwind (segue: UIStoryboardSegue) {
        //선택된 카테고리 색에 따라 이미지 변경
        showColorImage.image = UIImage(named: getImageChange)
    }
    
    //카테고리 저장
    func saveCategory(){
        let newCategory = Category(categoryName: nameTextField.text!, categoryColor: calculateColorInt(color: getImageChange))
        
        try! api.realm.write(){
            api.realm.add([newCategory])
        }
    }
    
    //'완료'버튼 누를때 action 함수
    @IBAction func completeModal(_ sender: Any) {
        saveCategory()
        //unwind실행(SettingViewController로)
        performSegue(withIdentifier: "unwindToSetting", sender: self)
        

    }
    
    //'취소' 버튼 누를때 action함수
    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        //커서+키보드 반응
        self.nameTextField.becomeFirstResponder()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)

    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "chooseColor", sender: nil)
        }
    }
    
    //이미지 파일 String에서 카테고리 DB categoryColor:Int로 쓰기 위해 변환
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
    
    

}

