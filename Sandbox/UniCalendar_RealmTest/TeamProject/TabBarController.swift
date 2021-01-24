//
//  TabBarController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/22.
//

import UIKit
import RealmSwift

class TabBarController: UITabBarController {
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    var subEvents: [SubEvent] = api.callSubEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
       
        
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
