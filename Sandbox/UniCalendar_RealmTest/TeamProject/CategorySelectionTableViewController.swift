////
////  CategorySelectionTableViewController.swift
////  TeamProject
////
////  Created by KM on 2021/01/19.
////
//
//import UIKit
//
//class CategorySelectionTableViewController: UIViewController, UITableViewDataSource {
//    
//    var categories: [CategoryItem] = Category.shared.categories
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        categories.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectionCell", for: indexPath)
//        
//        cell.textLabel?.text = categories[indexPath.row].categoryName
//        
//        return cell
//    }
//    
//
//    @IBOutlet var tableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    @IBAction func cancelModal(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @IBAction func completeModal(_ sender: Any) {
//        // todo
//        // add selected category to event
//        self.dismiss(animated: true, completion: nil)
//    }
//}
