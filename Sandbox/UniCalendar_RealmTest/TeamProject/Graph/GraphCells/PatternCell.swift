//
//  PatternCell.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/17.
//

import UIKit
import Charts

class PatternCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    
    @IBOutlet weak var patternLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var collectionView: UICollectionView!
    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var numOfCategory = 0
//
//        for category in categories{
//            var isInCategory = false
//            for i in 0..<category.eventsInCategory.count {
//                let dCalendar = Calendar.current.dateComponents([.year, .month], from: category.eventsInCategory[i].eventDday)
//                if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
//                    isInCategory = true
//                }
//            }
//            if isInCategory == true {
//                numOfCategory += 1
//            }
//        }
//        return numOfCategory
       
        return categories.count
        
    //    return categories.filter({ $0.eventsInCategory.count > 0 }).count
    
    
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        var isInCategory = false
        var numOfEvents = 0
//        let data = categories.filter({ $0.eventsInCategory.count > 0 })[indexPath.row]
        
        for i in 0..<categories[indexPath.row].eventsInCategory.count{
            let dCalendar = Calendar.current.dateComponents([.year, .month], from: categories[indexPath.row].eventsInCategory[i].eventDday)
           
            if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
                isInCategory = true
                numOfEvents += 1

            }
            
        }
        
        cell.categoryNameLabel.text = categories[indexPath.row].categoryName
        cell.eventNumLabel.text = String(numOfEvents) + " 개 "

//        if isInCategory == true {
//            cell.categoryNameLabel.text = categories[indexPath.row].categoryName
//            cell.eventNumLabel.text = String(numOfEvents) + " 개 "
//        }
//        }else{
//
//        }
//
//            cell.categoryNameLabel.text = categories[indexPath.row].categoryName
//            cell.eventNumLabel.text = String(categories[indexPath.row].eventsInCategory.count) + " 개 "
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 70, height: 90)
//    }
    
    
//    @IBAction func segDidChanged(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            <#code#>
//        case 1:
//
//        default:
//            break
//        }
//        }
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
