//
//  Cell.swift
//  TeamProject
//
//  Created by 김준경 on 2021/01/25.
//

import UIKit

var numOfCall = 0
var numOfLastCall = 0

class Cell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var eventNumLabel: UILabel!
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    var category : Category = Category()
    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
  
    func changeCollectionView(){
        var numOfEvents = 0
//        if categories.count == 0 { return }
        
        for i in 0..<categories[numOfCall].eventsInCategory.count{
            let dCalendar = Calendar.current.dateComponents([.year, .month], from: categories[numOfCall].eventsInCategory[i].eventDday)
           
            if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
                numOfEvents += 1
            }
        }
        
        categoryNameLabel.text = categories[numOfCall].categoryName
        eventNumLabel.text = String(numOfEvents) + " 개 "
        addNumOfCall(num: &numOfCall)
    }
    
    func addNumOfCall(num: inout Int){
        num += 1
    }
    
    func changeLastCollectionView(){
        var numOfEvents = 0
        
            print(numOfCall, numOfLastCall)
            print("---------체인지지난콜렉션 뷰--------")
        for i in 0..<categories[numOfLastCall].eventsInCategory.count{
            let dCalendar = Calendar.current.dateComponents([.year, .month], from: categories[numOfLastCall].eventsInCategory[i].eventDday)
           
            if ((dCalendar.year == today.year) && ((dCalendar.month! + 1) == today.month) && today.month != 1) || (((dCalendar.year! + 1) == today.year) && today.month == 1 && dCalendar.month! == 12){
                
                numOfEvents += 1
            }
        }
        categoryNameLabel.text = categories[numOfLastCall].categoryName
    
        eventNumLabel.text = String(numOfEvents) + " 개 "
        addNumOfCall(num: &numOfLastCall)
    }
//
    func setLayout() {
        categories = api.callCategory()
        events = api.callEvent()
        print(categories.count)
//        if categories.count == numOfCall {
//            numOfCall = 0
//        }
        print(numOfCall)
        changeCollectionView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categories = api.callCategory()
        events = api.callEvent()
        print(categories.count)
        
        print(numOfCall)
        changeCollectionView()
    }
}
