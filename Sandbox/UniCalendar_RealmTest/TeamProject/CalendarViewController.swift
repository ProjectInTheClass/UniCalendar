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
    
    var categories = api.callCategory()
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
        print(events)
    
        calendarEventTableView.dataSource = self
        calendarEventTableView.delegate = self
        
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.appearance.eventDefaultColor = UIColor.purple
        calendarView.appearance.eventSelectionColor = UIColor.purple
        
        calendarView.scrollDirection = .horizontal
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        events = api.callEvent()
        categories = api.callCategory()
        for event in events {
            let day = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!
            eventDates.append(day)
        }
        self.calendarEventTableView.reloadData()
    }
    
}


extension CalendarViewController : FSCalendarDelegateAppearance, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = calendarEventTableView.dequeueReusableCell(withIdentifier: "CalendarEventTableViewCell", for: indexPath) as! CalendarEventTableViewCell
        let event = selectedDateEvents[indexPath.row]
        
        cell.eventNameLabel.text = event.eventName
        
        let categoryColor = calculateColor(color: event.parentCategory[0].categoryColor)
        cell.categoryColorImage.image = UIImage(named: categoryColor)
        
        let today = dateFormatter.date(from: dateFormatter.string(from : Date.init()))
        let dDay = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!

        let interval = dDay.timeIntervalSince(today!)
        let d = Int(interval / 86400)
        
        if d < 0 {
            cell.dDayLabel.text = "D + " + String(-Int(d))
        } else {
            cell.dDayLabel.text = "D - " + String(d)
        }
        
        // 완료한 세부 목표 / 세부 목표 출력하기
        
        return cell
    }
    
    //data에서 카테고리 불러왔을때 Int->String으로 변환해서 image색깔 바꿔주는 함수
    func calculateColor(color: Int) -> String{
        switch color {
        case 0:
            return "category_purple"
        case 1:
            return "category_blue"
        case 2:
            return "category_red"
        case 3:
            return "category_yellow"
        case 4:
            return "category_green"
        case 5:
            return "category_orange"
        default:
            return "category_purple"
        }
    }
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
//        print(dateFormatter.string(from: date) + " 선택됨")
        selectedDateEvents.removeAll()
        
        for event in events {
            let date_ = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!
            if date_ == date {
                selectedDateEvents.append(event)
            }
        }
        print(selectedDateEvents)
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

}



