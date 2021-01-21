//
//  CalendarViewController.swift
//  TeamProject
//
//  Created by 김준경 on 2021/01/18.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate {
 
    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var calendarEventTableView: UITableView!
    @IBOutlet weak var eventLabel: UILabel!
    
    var events: [Event] = api.callEvent()
    var eventDates = [Date]()
    var selectedDateEvents = [Event]()
    
    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        calendarEventTableView.dataSource = self
        calendarEventTableView.delegate = self
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.appearance.eventDefaultColor = UIColor.purple
        calendarView.appearance.eventSelectionColor = UIColor.purple
        
        calendarView.scrollDirection = .vertical
        
        for event in events {
            print(event)
            let day = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!
            eventDates.append(day)
        }
        
    }
    
}


extension CalendarViewController : FSCalendarDelegateAppearance, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedDateEvents)
        print("zzzzzzzzzzzzzzzzzzzzzzzzzzzZ")
        return selectedDateEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = calendarEventTableView.dequeueReusableCell(withIdentifier: "CalendarEventCell", for: indexPath)
        let event = selectedDateEvents[indexPath.row]
        
        eventLabel.text = event.eventName
      
        return cell
    }
    
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print(dateFormatter.string(from: date) + " 선택됨")
        selectedDateEvents.removeAll()
        for event in events {
            if event.eventDday == date {
                selectedDateEvents.append(event)
            }
        }
       
        calendarEventTableView.reloadData()
       
    }
    
    
    // 날짜 선택 해제 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    //이벤트 표시 개수
       func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
           if self.eventDates.contains(date) {
               return 1
           } else {
               return 0
           }
       }
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//
//            switch dateFormatter.string(from: date) {
//            case dateFormatter.string(from: Date()):
//                return "오늘"
//            case "2021-01-19":
//                return "시험"
//            case "2021-01-23":
//                return "알고리즘 과제"
//            case "2021-01-11":
//                return "대외활동"
//            default:
//                return nil
//            }
//        }
    
}



