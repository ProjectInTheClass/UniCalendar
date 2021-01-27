//
//  CalendarEventTableViewCell.swift
//  TeamProject
//
//  Created by 김준경 on 2021/01/22.
//

import UIKit

class CalendarEventTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryColorImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var subCompletionLabel: UILabel!
    
//    var dateFormatter:DateFormatter {
//        let df = DateFormatter()
//        df.dateFormat = "yyyy-MM-dd"
//        return df
//    }
//    var categories = api.callCategory()
//    var events: [Event] = api.callEvent()
//    var todayEvents = [Event]()
//
//    func drawTable(){
//        let today = dateFormatter.date(from: dateFormatter.string(from: Date.init()))!
//        for event in events {
//            let date = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!
//            if today == date {
//                todayEvents.append(event)
//            }
//        }
//
//        for i in 0..<todayEvents.count{
//            let event = todayEvents[i]
//
//            eventNameLabel.text = event.eventName
//
//            let categoryColor = calculateColor(color: event.parentCategory[0].categoryColor)
//            categoryColorImage.image = UIImage(named: categoryColor)
//
//            // 완료한 세부 목표 / 세부 목표 출력하기
//            var count: Int = 0
//            for subEvents in event.subEvents {
//                if subEvents.subEventIsDone == true {
//                    count+=1
//                }
//            }
//
//            subCompletionLabel.textColor = UIColor.gray
//
//            if event.subEvents.count == 0 {
//                subCompletionLabel.text = "세부 목표가 없어요🙅"
//            } else {
//                subCompletionLabel.text = "세부 목표 : " + String(count) + " / " + String(event.subEvents.count)
//            }
//        }
//
//    }
//
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
//            return "category_purple"
//        }
//    }
//
//
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//       drawTable()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
