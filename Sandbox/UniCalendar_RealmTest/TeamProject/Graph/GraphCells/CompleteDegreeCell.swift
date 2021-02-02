////
////  CompleteDegreeCell.swift
////  TeamProject
////
////  Created by Nayeon Kim on 2021/01/17.
////
//
//import UIKit
//import Charts
//
//class CompleteDegreeCell: UITableViewCell {
//
//    @IBOutlet weak var completeLabel: UILabel!
//    @IBOutlet weak var barChartView: BarChartView!
//    @IBOutlet weak var totalLabel: UILabel!
//    @IBOutlet weak var numOfTotalLabel: UILabel!
//    @IBOutlet weak var completionLabel: UILabel!
//    @IBOutlet weak var numOfCompletionLabel: UILabel!
//    @IBOutlet weak var averageCompletion: UILabel!
//    @IBOutlet weak var completionRateComparison: UILabel!
//    @IBOutlet weak var upDownLabel: UILabel!
//    @IBOutlet weak var comparisonLabel: UILabel!
//    
//    var events: [Event] = api.callEvent()
//    var subEvents: [SubEvent] = api.callSubEvent()
//    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        events = api.callEvent()
//        subEvents = api.callSubEvent()
//        countEventsNumAndRate()
//        
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
// 
//    func countEventsNumAndRate(){
//        
//        totalLabel.text = "총 목표 수"
//        completionLabel.text = "🔥완료한 목표 수"
//        var numOfTotal = 0
//        var numOfCompletion = 0
//        var numOfLastMonthTotal = 0
//        var numOfLastMonthCompletion = 0
//        
//        for i in 0..<events.count{
//            let dCalendar = Calendar.current.dateComponents([.year, .month], from:events[i].eventDday)
//            if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
//                numOfTotal += 1
//                if events[i].eventIsDone {
//                    numOfCompletion += 1
//                    
//                }
//            }
//            if ((dCalendar.year == today.year) && ((dCalendar.month! + 1) == today.month) && today.month != 1) || (((dCalendar.year! + 1) == today.year) && today.month == 1 && dCalendar.month! == 12) {
//                numOfLastMonthTotal += 1
//                if events[i].eventIsDone {
//                    numOfLastMonthCompletion += 1
//                }
//            }
//        }
//        let average = Double(numOfCompletion) / Double(numOfTotal) * 100
//       
//        numOfTotalLabel.text = String(numOfTotal) + " 개"
//        numOfCompletionLabel.text = String(numOfCompletion) + " 개"
//        
//        if numOfTotal == 0 {
//            averageCompletion.text = "0%"
//            comparisonLabel.text = "아직 지난 달과 비교할 데이터가 없어요😢"
//            
//            completionRateComparison.text = ""
//            upDownLabel.text = ""
//            
//        } else {
//            averageCompletion.text = String(format: "%.0f", average) + "%"
//            comparisonLabel.text = "저번 달보다 성공률이"
//            if numOfLastMonthTotal != 0{
//                let lastMonthAverage = Double(numOfLastMonthCompletion) / Double(numOfLastMonthTotal) * 100
//                let comparison = average - lastMonthAverage
//                completionRateComparison.text = String(format: "%.2f", comparison) + "%"
//                if comparison == 0 {
//                    comparisonLabel.text = "저번 달과 성공률이"
//                    completionRateComparison.text = "100%"
//                    upDownLabel.text = "일치해요🙌🏻"
//                } else if comparison > 0 {
//                    upDownLabel.text = "높아요👏🏻"
//                } else {
//                    upDownLabel.text = "낮아요😦"
//                }
//            }else {
//                comparisonLabel.text = "지난 달에는 등록한 목표가 없어요🤭"
//                completionRateComparison.text = ""
//                upDownLabel.text = ""
//            }
//        }
//    }
//    
//    func countSubEventsNumAndRate(){
//        totalLabel.text = "총 세부 목표 수"
//        completionLabel.text = "🔥완료한 세부 목표 수"
//        var numOfTotal = 0
//        var numOfCompletion = 0
//        var numOfLastMonthTotal = 0
//        var numOfLastMonthCompletion = 0
//        
//        for i in 0..<subEvents.count{
//            let dCalendar = Calendar.current.dateComponents([.year, .month], from:subEvents[i].parentEvent[0].eventDday)
//            if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
//                numOfTotal += 1
//                if subEvents[i].subEventIsDone {
//                    numOfCompletion += 1
//                }
//            }
//            if ((dCalendar.year == today.year) && ((dCalendar.month! + 1) == today.month) && today.month != 1) || (((dCalendar.year! + 1) == today.year) && today.month == 1 && dCalendar.month! == 12) {
//                numOfLastMonthTotal += 1
//                if subEvents[i].subEventIsDone {
//                    numOfLastMonthCompletion += 1
//                }
//            }
//        }
//        let average = Double(numOfCompletion) / Double(numOfTotal) * 100
//       
//        numOfTotalLabel.text = String(numOfTotal) + " 개"
//        numOfCompletionLabel.text = String(numOfCompletion) + " 개"
//        
//        if numOfTotal == 0 {
//            averageCompletion.text = "0%"
//            comparisonLabel.text = "아직 지난 달과 비교할 데이터가 없어요😢"
//            
//            completionRateComparison.text = ""
//            upDownLabel.text = ""
//            
//        } else {
//            averageCompletion.text = String(format: "%.0f", average) + "%"
//            comparisonLabel.text = "저번 달보다 성공률이"
//            if numOfLastMonthTotal != 0{
//                let lastMonthAverage = Double(numOfLastMonthCompletion) / Double(numOfLastMonthTotal) * 100
//                let comparison = average - lastMonthAverage
//                completionRateComparison.text = String(format: "%.2f", comparison) + "%"
//                if comparison == 0 {
//                    comparisonLabel.text = "저번 달과 성공률이"
//                    completionRateComparison.text = "100%"
//                    upDownLabel.text = "일치해요🙌🏻"
//                } else if comparison > 0 {
//                    upDownLabel.text = " 높아요👏🏻"
//                } else {
//                    upDownLabel.text = " 낮아요😦"
//                }
//            }else {
//                comparisonLabel.text = "지난 달에는 등록한 세부 목표가 없어요🤭"
//                completionRateComparison.text = ""
//                upDownLabel.text = ""
//            }
//        }
//    }
//    
//    @IBAction func segDidChange(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            countEventsNumAndRate()
//            
//        case 1:
//            countSubEventsNumAndRate()
//        default:
//            break
//        }
//    }
//}
