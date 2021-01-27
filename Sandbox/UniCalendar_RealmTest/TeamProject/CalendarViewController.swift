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
    var showToday: Int = 0
    
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
        // 스와이프 스크롤 작동 여부 ( 활성화하면 좌측 우측 상단에 다음달 살짝 보임, 비활성화하면 사라짐 )
        
        calendarView.scrollDirection = .horizontal
        
        //스와이프 양옆으로 흐리게 다음/전달 보이는거
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        //headerDateFormat
        calendarView.appearance.headerDateFormat = "YYYY년 MM월"
        
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "월"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "화"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "수"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "목"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "금"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "토"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "일"
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        events = api.callEvent()
        categories = api.callCategory()
        //기존에 저장되어있던 eventDates 모두 삭제
        eventDates.removeAll()

        //새로 eventDates append해줌
        for event in events {
            let day = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!
            eventDates.append(day)
        }
        
        //reload data for both calendar & table view, selectedDateEvents data remove
        selectedDateEvents.removeAll()
        calendarView.reloadData()
        self.calendarEventTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        for date in eventDates{
            calendarView.deselect(date)
        }
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
        
        // 완료한 세부 목표 / 세부 목표 출력하기
        var count: Int = 0
        for subEvents in event.subEvents {
            if subEvents.subEventIsDone == true {
                count+=1
            }
        }
        
        cell.subCompletionLabel.textColor = UIColor.gray
        
        if event.subEvents.count == 0 {
            cell.subCompletionLabel.text = "세부 목표가 없어요🙅"
        } else {
            cell.subCompletionLabel.text = "세부 목표 : " + String(count) + " / " + String(event.subEvents.count)
        }
        
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
        selectedDateEvents.removeAll()
        
        for event in events {
            let date_ = dateFormatter.date(from: dateFormatter.string(from: event.eventDday))!
            if date_ == date {
                selectedDateEvents.append(event)
            }
        }
        calendarEventTableView.reloadData()
       
    }
    
    
    // 날짜 선택 해제 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
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



