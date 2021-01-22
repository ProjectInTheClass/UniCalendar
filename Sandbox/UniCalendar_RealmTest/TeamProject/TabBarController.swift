//
//  TabBarController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var defaultCategory = api.callCategory()
        
        let hwCategory = Category(categoryName: "📓과제", categoryColor: 0)
        let examCategory = Category(categoryName: "📝시험", categoryColor: 1)
        let activityCategory = Category(categoryName: "👥대외활동", categoryColor: 2)
        
        
        if defaultCategory.count == 0 {
            try! api.realm.write(){
                api.realm.add(hwCategory)
                api.realm.add(examCategory)
                api.realm.add(activityCategory)
            }
        }
        
        defaultCategory = api.callCategory()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
