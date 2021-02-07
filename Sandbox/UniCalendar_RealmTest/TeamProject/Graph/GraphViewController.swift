//import UIKit
//import Charts
//
//class GraphViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//   
//    let semiSection : [String] = ["배지🎖", "전체 보기▶️", "대학 생활 패턴 분석🔍", "완료도 분석📊"]
//    var categories : [Category] = api.callCategory()
//    var events: [Event] = api.callEvent()
//    var pieDataEntries = [PieChartDataEntry]()
//    var dataPoints:[String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
//    var barDataEntriesOfEvents = [BarChartDataEntry]()
//    var barDataEntriesOfSubEvents = [BarChartDataEntry]()
//    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
//    
//    func updateBarChartData(){
//        
//        var numOfCompletedEvents = [Int](repeating: 0, count: 12)
//        var numOfCompletedSubEvents = [Int](repeating: 0, count: 12)
//
//        let year = Calendar.current.component(.year, from: Date.init())
//        barDataEntriesOfEvents.removeAll()
//        barDataEntriesOfSubEvents.removeAll()
//        
//        for i in 0...11 {
//            for event in events{
//                let components = Calendar.current.dateComponents([.year, .month], from: event.eventDday)
//                if (year == components.year) && ((i + 1) == components.month) && event.eventIsDone == true{
//                    numOfCompletedEvents[i] += 1
//                    for j in 0..<event.subEvents.count{
//                        if event.subEvents[j].subEventIsDone {
//                            numOfCompletedSubEvents[i] += 1
//                        }
//                    }
//                }
//            }
//            let dataEntryOfEvents = BarChartDataEntry(x: Double(i), y : Double(numOfCompletedEvents[i]))
//            let dataEntryOfSubEvents = BarChartDataEntry(x: Double(i), y : Double(numOfCompletedSubEvents[i]))
//            barDataEntriesOfEvents.append(dataEntryOfEvents)
//            barDataEntriesOfSubEvents.append(dataEntryOfSubEvents)
//        }
//    }
//
//    
//    func calculateColor(color: Int) -> String{
//        switch color {
//        case 0:
//            return "purple"
//        case 1:
//            return "blue"
//        case 2:
//            return "red"
//        case 3:
//            return "yellow"
//        case 4:
//            return "green"
//        case 5:
//            return "orange"
//        default:
//            return "purple"
//        }
//    }
//    
//    
//    override func viewDidAppear(_ animated: Bool) {
//        categories = api.callCategory()
//        events = api.callEvent()
//        tableView.reloadData()
//    }
////    override func viewWillAppear(_ animated: Bool) {
////          categories = api.callCategory()
////          events = api.callEvent()
////          tableView.reloadData()
////      }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//}
//
//extension GraphViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let format = NumberFormatter()
//        format.numberStyle = .none
//        format.zeroSymbol = "";
//        
//        let formatter = DefaultValueFormatter(formatter: format)
//
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PatternCell", for: indexPath) as! PatternCell
//            cell.patternLabel.text = semiSection[2]
//            isClicked = true
//            flag = true
//            cell.setLayouts()
//            return cell
//        }
//        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDegreeCell", for: indexPath) as! CompleteDegreeCell
//
//            cell.completeLabel.text = semiSection[3]
//            updateBarChartData()
//            let barChartDataSet = BarChartDataSet(entries: barDataEntriesOfEvents, label: "완료 목표 수")
//            let barChartDataSetOfSub = BarChartDataSet(entries: barDataEntriesOfSubEvents, label: "완료 세부 목표 수")
//            let dataSets: [BarChartDataSet] = [barChartDataSet,barChartDataSetOfSub]
//            let barChartData = BarChartData(dataSets: dataSets)
//            
//            barChartData.setValueFormatter(formatter)
//            barChartDataSet.colors = [UIColor(named: "purple")!]
//            barChartDataSetOfSub.colors = [UIColor(named: "pink")!]
//            let groupSpace = 0.3
//            let barSpace = 0.05
//            let barWidth = 0.3
//            barChartData.barWidth = barWidth;
////            cell.barChartView.xAxis.axisMinimum = Double(0)
//            let gg = barChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
//            cell.barChartView.xAxis.axisMaximum = Double(0) + gg * Double(12)
//            barChartData.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
//            cell.barChartView.notifyDataSetChanged()
//            cell.barChartView.xAxis.gridColor = .clear
//            cell.barChartView.xAxis.labelPosition = .bottom
//            cell.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
//            cell.barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
//            cell.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
//            cell.barChartView.rightAxis.enabled = false
//            cell.barChartView.data = barChartData
//            
//            return cell
//        }
//
//    }
//
//    
//}


import UIKit
import Charts

class GraphViewController: UIViewController {
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var numOfTotalLabel: UILabel!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var numOfCompletionLabel: UILabel!
    @IBOutlet weak var averageCompletion: UILabel!
    @IBOutlet weak var comparisonLabel: UILabel!
    @IBOutlet weak var completionRateComparison: UILabel!
    @IBOutlet weak var upDownLabel: UILabel!
    
    var pieDataEntries = [PieChartDataEntry]()
    var dataPoints:[String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
    var barDataEntriesOfEvents = [BarChartDataEntry]()
    var barDataEntriesOfSubEvents = [BarChartDataEntry]()
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    var subEvents: [SubEvent] = api.callSubEvent()
    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBarChart()
        
    }
    
    func calculateColor(color: Int) -> String{
        switch color {
        case 0:
            return "purple"
        case 1:
            return "blue"
        case 2:
            return "red"
        case 3:
            return "yellow"
        case 4:
            return "green"
        case 5:
            return "orange"
        default:
            return "purple"
        }
    }

    @IBAction func patternSegDidChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            drawPieChart(isLastMonth: true)
        case 1:
            drawPieChart(isLastMonth: false)
        default:
            break
        }
    }
    
    @IBAction func completionSegdidChanged(_ sender: UISegmentedControl) {
        events = api.callEvent()
        subEvents = api.callSubEvent()
        drawBarChart()
        switch sender.selectedSegmentIndex {
        case 0:
            countEventsNumAndRate()
        case 1:
            countSubEventsNumAndRate()
        default:
            break
        }
    }
    
}

extension GraphViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        
        return cell
    }
    
    
}

extension GraphViewController {
    
    func drawPieChart(isLastMonth: Bool) {
        let format = NumberFormatter()
        format.numberStyle = .none
        format.zeroSymbol = "";
        let formatter = DefaultValueFormatter(formatter: format)
        pieDataEntries.removeAll()
        var colors:[UIColor] = []

        for category in categories{
            let color = calculateColor(color: category.categoryColor)

            colors.append( UIColor(named: color)! )
        }

        for category in categories{
            var numOfEvent = 0
            var isInCategory = false
            let dataEntry = PieChartDataEntry()
            for i in 0..<category.eventsInCategory.count {
                let dCalendar = Calendar.current.dateComponents([.year, .month], from: category.eventsInCategory[i].eventDday)
                if isLastMonth {
                    if ((dCalendar.year == today.year) && ((dCalendar.month! + 1) == today.month) && today.month != 1) || (((dCalendar.year! + 1) == today.year) && today.month == 1 && dCalendar.month! == 12) {
                        numOfEvent += 1
                        isInCategory = true
                    }
                }else {
                    if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
                        numOfEvent += 1
                        isInCategory = true
                    }
                }

            }

            if isInCategory == true {
                dataEntry.value = Double(numOfEvent)
                dataEntry.label = category.categoryName
                pieDataEntries.append(dataEntry)
                let color = calculateColor(color: category.categoryColor)

                colors.append( UIColor(named: color)! )
            }
        }
        let pieChartDataSet = PieChartDataSet(entries: pieDataEntries, label: nil)
        let pieChartData = PieChartData(dataSet: pieChartDataSet)

        pieChartDataSet.colors = colors
        pieChartData.setValueFormatter(formatter)

        pieChartView.animate(xAxisDuration: 1.0)
        pieChartView.data = pieChartData
    }

    func drawBarChart(){
        var numOfCompletedEvents = [Int](repeating: 0, count: 12)
        var numOfCompletedSubEvents = [Int](repeating: 0, count: 12)

        let year = Calendar.current.component(.year, from: Date.init())
        barDataEntriesOfEvents.removeAll()
        barDataEntriesOfSubEvents.removeAll()
        
        for i in 0...11 {
            for event in events{
                let components = Calendar.current.dateComponents([.year, .month], from: event.eventDday)
                if (year == components.year) && ((i + 1) == components.month) && event.eventIsDone == true{
                    numOfCompletedEvents[i] += 1
                    for j in 0..<event.subEvents.count{
                        if event.subEvents[j].subEventIsDone {
                            numOfCompletedSubEvents[i] += 1
                        }
                    }
                }
            }
            let dataEntryOfEvents = BarChartDataEntry(x: Double(i), y : Double(numOfCompletedEvents[i]))
            let dataEntryOfSubEvents = BarChartDataEntry(x: Double(i), y : Double(numOfCompletedSubEvents[i]))
            barDataEntriesOfEvents.append(dataEntryOfEvents)
            barDataEntriesOfSubEvents.append(dataEntryOfSubEvents)
        }
        let format = NumberFormatter()
        format.numberStyle = .none
        format.zeroSymbol = "";
        
        let formatter = DefaultValueFormatter(formatter: format)
        
        let barChartDataSet = BarChartDataSet(entries: barDataEntriesOfEvents, label: "완료 목표 수")
        let barChartDataSetOfSub = BarChartDataSet(entries: barDataEntriesOfSubEvents, label: "완료 세부 목표 수")
        let dataSets: [BarChartDataSet] = [barChartDataSet,barChartDataSetOfSub]
        let barChartData = BarChartData(dataSets: dataSets)
        
        barChartData.setValueFormatter(formatter)
        barChartDataSet.colors = [UIColor(named: "purple")!]
        barChartDataSetOfSub.colors = [UIColor(named: "pink")!]
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        barChartData.barWidth = barWidth;
//            cell.barChartView.xAxis.axisMinimum = Double(0)
        let gg = barChartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.xAxis.axisMaximum = Double(0) + gg * Double(12)
        barChartData.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
        barChartView.notifyDataSetChanged()
        barChartView.xAxis.gridColor = .clear
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        barChartView.rightAxis.enabled = false
        barChartView.data = barChartData
    }
    
    func countEventsNumAndRate(){
        
        totalLabel.text = "총 목표 수"
        completionLabel.text = "🔥완료한 목표 수"
        var numOfTotal = 0
        var numOfCompletion = 0
        var numOfLastMonthTotal = 0
        var numOfLastMonthCompletion = 0
        
        for i in 0..<events.count{
            let dCalendar = Calendar.current.dateComponents([.year, .month], from:events[i].eventDday)
            if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
                numOfTotal += 1
                if events[i].eventIsDone {
                    numOfCompletion += 1
                    
                }
            }
            if ((dCalendar.year == today.year) && ((dCalendar.month! + 1) == today.month) && today.month != 1) || (((dCalendar.year! + 1) == today.year) && today.month == 1 && dCalendar.month! == 12) {
                numOfLastMonthTotal += 1
                if events[i].eventIsDone {
                    numOfLastMonthCompletion += 1
                }
            }
        }
        setLabels(numOfCompletion: numOfCompletion, numOfTotal: numOfTotal, numOfLastMonthCompletion: numOfLastMonthCompletion, numOfLastMonthTotal: numOfLastMonthTotal, subEventLabel: "")
        
    }
    
   
    func countSubEventsNumAndRate(){
        totalLabel.text = "총 세부 목표 수"
        completionLabel.text = "🔥완료한 세부 목표 수"
        var numOfTotal = 0
        var numOfCompletion = 0
        var numOfLastMonthTotal = 0
        var numOfLastMonthCompletion = 0
        
        for i in 0..<subEvents.count{
            let dCalendar = Calendar.current.dateComponents([.year, .month], from:subEvents[i].parentEvent[0].eventDday)
            if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
                numOfTotal += 1
                if subEvents[i].subEventIsDone {
                    numOfCompletion += 1
                }
            }
            if ((dCalendar.year == today.year) && ((dCalendar.month! + 1) == today.month) && today.month != 1) || (((dCalendar.year! + 1) == today.year) && today.month == 1 && dCalendar.month! == 12) {
                numOfLastMonthTotal += 1
                if subEvents[i].subEventIsDone {
                    numOfLastMonthCompletion += 1
                }
            }
        }
        setLabels(numOfCompletion: numOfCompletion, numOfTotal: numOfTotal, numOfLastMonthCompletion: numOfLastMonthCompletion, numOfLastMonthTotal: numOfLastMonthTotal, subEventLabel: "세부 ")
    }
    func setLabels(numOfCompletion:Int, numOfTotal: Int, numOfLastMonthCompletion: Int, numOfLastMonthTotal:Int, subEventLabel:String){
        let average = Double(numOfCompletion) / Double(numOfTotal) * 100
       
        numOfTotalLabel.text = String(numOfTotal) + " 개"
        numOfCompletionLabel.text = String(numOfCompletion) + " 개"
        
        if numOfTotal == 0 {
            averageCompletion.text = "0%"
            comparisonLabel.text = "아직 지난 달과 비교할 데이터가 없어요😢"
            
            completionRateComparison.text = ""
            upDownLabel.text = ""
            
        } else {
            averageCompletion.text = String(format: "%.0f", average) + "%"
            comparisonLabel.text = "저번 달보다 성공률이"
            if numOfLastMonthTotal != 0{
                let lastMonthAverage = Double(numOfLastMonthCompletion) / Double(numOfLastMonthTotal) * 100
                let comparison = average - lastMonthAverage
                completionRateComparison.text = String(format: "%.2f", comparison) + "%"
                if comparison == 0 {
                    comparisonLabel.text = "저번 달과 성공률이"
                    completionRateComparison.text = "100%"
                    upDownLabel.text = "일치해요🙌🏻"
                } else if comparison > 0 {
                    upDownLabel.text = "높아요👏🏻"
                } else {
                    upDownLabel.text = "낮아요😦"
                }
            }else {
                comparisonLabel.text = "지난 달에는 등록한 " + subEventLabel + "목표가 없어요🤭"
                completionRateComparison.text = ""
                upDownLabel.text = ""
            }
        }
    }
    
}
