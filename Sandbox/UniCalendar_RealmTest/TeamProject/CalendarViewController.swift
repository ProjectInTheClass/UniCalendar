//
//  CalendarViewController.swift
//  TeamProject
//
//  Created by 김준경 on 2021/01/18.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBOutlet weak var calendarView: FSCalendar!
    
    var events: [Event] = api.callEvent()
    var eventDates = [Date]()
    
    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.appearance.eventDefaultColor = UIColor.purple
        calendarView.appearance.eventSelectionColor = UIColor.green
        
        calendarView.scrollDirection = .vertical
        
        //        let xmas = dateFormatter.date(from: "2021-01-22")
        //        let sampledate = dateFormatter.date(from: "2021-01-22")
        //        events = [xmas!, sampledate!]
                
        
        
        for event in events {
            print(event)
//            let day = dateFormatter.event.eventDday
//            eventDates.append(day)
        }
        
    }
    

}


extension CalendarViewController : FSCalendarDelegateAppearance {
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        
    }
    // 날짜 선택 해제 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
        
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
            
            switch dateFormatter.string(from: date) {
            case dateFormatter.string(from: Date()):
                return "오늘"
            case "2021-01-19":
                return "시험"
            case "2021-01-23":
                return "알고리즘 과제"
            case "2021-01-11":
                return "대외활동"
            default:
                return nil
            }
        }

    
    
    //이벤트 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.eventDates.contains(date) {
            print("이써")
            return 1
        } else {
            print("없으")
            return 0
        }
    }
}



