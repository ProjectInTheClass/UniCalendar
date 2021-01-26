//
//  EventAddTableViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/19.
//

import UIKit
import UserNotifications

let api = API.shared

class EventAddTableViewController: UITableViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    // 빈도
    // 0: 없음, 1:매일, 2: 사용자설정
    var checkedFrequency: Int = 0
    
    // checkedFrequency가 2 일때, 월(0)~일(6) 중 선택된 요일값 배열
    // checkedFrequency가 0또는 1이면(없거나 매일이면) 빈 배열
    var checkedDaysOfWeek: [Int] = Array<Int>()
    var checkedTime: Int = 0
    
    var categoryString: String = ""
    var selectedCategory: Int = 0
    
    var notificationFrequency: String = ""
    var notificationTime: String = ""
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var newEventName: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var showImportance: UILabel!
    @IBOutlet weak var importanceSlider: UISlider!
    
    @IBOutlet weak var settledNotificationInfoLabel: UILabel!
   
    
    var event = api.callEvent()
    var doneEvent = api.callPassedEvent()
    var notDoneEvent = api.callNotPassedEvent()
    var category = api.callCategory()
    
    var dateFormatter:DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        switch seg.identifier {
        case "unwindToAddEventFromCategory":
            categoryLabel.text = category[selectedCategory].categoryName
            break
        case "unwindToAddEventFromNotification":
            settledNotificationInfoLabel.text = "\(notificationFrequency) \(notificationTime)"
            break
        default:
            break
        }
    }
    
    // Date() 두개 받아서 차이 리턴
    func getIntervalDayBetweenDates(from: Date, to: Date) -> Int {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let fromDate = df.date(from: df.string(from: from))
        let toDate = df.date(from: df.string(from: to))!

        let interval = toDate.timeIntervalSince(fromDate!)
        
        // dMinus
        return Int(interval / (3600 * 24))
    }

    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func completeModal(_ sender: Any) {
        // TODO
        // Add New event to EventList
        save()
        performSegue(withIdentifier: "unwindToHome", sender: (Any).self)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.newEventName.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.newEventName.resignFirstResponder()
//        dismiss(animated: true, completion: nil)
        return true
    }

    
//    @IBAction func changeImportanceBySlider(_ sender: Any) {
//        showImportance.text = String(importanceSlider.value)
//    }
    
    @IBAction func ringVolumeSliderChange(_ sender: UISlider)
    {
        sender.setValue(sender.value.rounded(.down), animated: false)
        showImportance.text = String(Int(importanceSlider.value))
    }
    
    func save() {

        var eventForNotification: Event = Event()
        
        // 이벤트 추가
        let pickedDate = dateFormatter.string(from: datePicker.date)
        let d = self.dateFormatter.date(from: pickedDate)
        let dCalendar = Calendar.current.dateComponents([.year, .month, .day], from: d!)
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
        
        if (dCalendar.year! < today.year!) || (dCalendar.year! <= today.year! && dCalendar.month! < today.month!) || (dCalendar.year! <= today.year! && dCalendar.month! <= today.month! && dCalendar.day! < today.day!) {

            let newEvent = Event(eventName: newEventName.text!, eventDday: d!, importance: Int(importanceSlider.value), eventIsDone: false, eventIsPassed: true)

            try! api.realm.write(){
                category[selectedCategory].eventsInCategory.append(newEvent)
                api.realm.add([newEvent])
            }
            eventForNotification = newEvent
        } else {
            let newEvent = Event(eventName: newEventName.text!, eventDday: d!, importance: Int(importanceSlider.value), eventIsDone: false, eventIsPassed: false)
           try! api.realm.write{
               category[selectedCategory].eventsInCategory.append(newEvent)
               api.realm.add([newEvent])
           }
            eventForNotification = newEvent
        }
        
        // Todo: step 값 계산하기 (begin:0 ~ end: 2 or 3?)

        let step: Int = 0 // begin
        
        // switch-case 안에서 호출시 checkedDayOfWeek 뺄수도 있음
        // 알림 설정에서사용자 선택-요일 이 선택된 상태가 아니면 아니면 빈배열
        
        savePushNotification(event: eventForNotification, step: step, frequency: checkedFrequency, time: checkedTime, daysOfWeek: checkedDaysOfWeek)
    }
    
    func savePushNotification(event: Event, step: Int, frequency: Int, time: Int, daysOfWeek: [Int]?) {
        print("함수 시작: savePushNotification")
        // let contents = api.callContent()
        
        // todo 데이터 구조 바꿔야함
        // 컨텐츠 안에 문자열 들어가는 구조로?
        // let content = contents[step]
        
        // 알림 메세지 구성
        // event id도 넣어줘야함
        
        let calendar = Calendar.current
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let dMinusWhenInit: Int = getIntervalDayBetweenDates(from: Date(), to: event.eventDday)
        
        if frequency == 0 {
            // do nothing
        } else if frequency == 1 { // everyday
            // D-Day 당일까지 포함이므로 offset값에 +1
            for offset in 0..<dMinusWhenInit+1 {
                let date = calendar.date(byAdding: .day, value: offset, to: Date())!
                var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .weekday], from: date)
                // 6시 9시 12시 ...
                dateComponents.hour = 6 + checkedTime*3
                
                let interval = getIntervalDayBetweenDates(from: date, to: event.eventDday)
                
                // notification content
                let notificationContent = UNMutableNotificationContent()
                notificationContent.title = "D-\(interval) \(event.eventName)"
                
                notificationContent.body = "\(event.eventName) at \(dateComponents.month ?? 0)월 \(dateComponents.day ?? 0)일 \(dateComponents.hour ?? -1)시 \(dateComponents.weekday ?? -1)요일"
                
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
                // identifier 나중에 데이터베이스에 저장해줘야함
                let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                    content: notificationContent,
                                                    trigger: trigger)
                // D-Day 까지만 등록하고, 이후에는 등록 안함.
                if interval >= 0 {
                    addNotificationToCenter(request: request, event: event)
                }
            }
        } else if frequency == 2 { // 사용자 설정
            if checkedDaysOfWeek.isEmpty {
                return
            }
            let weeks: Int = dMinusWhenInit / 7
            
            // 체크된 요일로 반복문
            for weekday in checkedDaysOfWeek {
                // week가 0이면 이번주
                // 오늘: 화요일, 디데이: 다음주 수요일이면 D-8
                // weeks 는 1이 되니까
                // +0(이번주), +1(다음주)까지 되려면
                // 반복문을 한 번 더 돌아야함
                // 그래서 0..<weeks"+1"
                for week in 0..<weeks+1 {
                    var weekdayDate: Date = Date()
                    switch weekday {
                    case 0:
                        weekdayDate = Date.today().next(.monday,  considerToday: true)
                    case 1:
                        weekdayDate = Date.today().next(.tuesday,  considerToday: true)
                    case 2:
                        weekdayDate = Date.today().next(.wednesday,  considerToday: true)
                    case 3:
                        weekdayDate = Date.today().next(.thursday,  considerToday: true)
                    case 4:
                        weekdayDate = Date.today().next(.friday,  considerToday: true)
                    case 5:
                        weekdayDate = Date.today().next(.saturday,  considerToday: true)
                    case 6:
                        weekdayDate = Date.today().next(.sunday,  considerToday: true)
                    default:
                        break;
                    }
                    
                    let date = calendar.date(byAdding: .day, value: 7*(week), to: weekdayDate)!
                    var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .weekday], from: date)
                    
                    dateComponents.hour = 6 + checkedTime * 3
                    
                    let interval = getIntervalDayBetweenDates(from: date, to: event.eventDday)
                    
                    // content
                    let notificationContent = UNMutableNotificationContent()
                    notificationContent.title = "D-\(interval) \(event.eventName)"
                    
                    notificationContent.body = "\(dateComponents.month ?? 0)월 \(dateComponents.day ?? 0)일 \(dateComponents.hour ?? -1)시 \(dateComponents.weekday ?? -1)요일"
                    
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                    
                    let notificationId = UUID().uuidString
                    // todo identifier 나중에 데이터베이스에 저장해줘야함
                    let request = UNNotificationRequest(identifier: notificationId,
                                                        content: notificationContent,
                                                        trigger: trigger)
                    // 알림 등록
                    if interval >= 0 {
                        addNotificationToCenter(request: request, event: event)
                    }
                }
            }
        } else {
            print("notification frequency setting error")
        }
    }
    
    func addNotificationToCenter(request: UNNotificationRequest, event: Event) {
        UNUserNotificationCenter.current().add(request) { error in
            guard error == nil else { return }
        }
        // debug when notification added
        print("!! Notification\ntitle:[\(request.content.title)]\nbody:\(request.content.body)")
    }
    // if process step is changed
    func removeNotifications(notificationIds: [String]) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: notificationIds)
    }
    //----------------------------알림 end--------------------
        
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newEventName.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        importanceSlider.value = 2
        showImportance.text = String(Int(importanceSlider.value))
        
    }
}


// Date Extension for get Weekday easily

/* https://stackoverflow.com/questions/33397101/how-to-get-mondays-date-of-the-current-week-in-swift/33397770
 */
extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex

    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

// MARK: Helper methods
extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    

}
