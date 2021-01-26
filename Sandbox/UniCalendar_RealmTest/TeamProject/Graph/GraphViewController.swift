import UIKit
import Charts

class GraphViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    let semiSection : [String] = ["배지🎖", "전체 보기▶️", "대학 생활 패턴 분석🔍", "완료도 분석📊"]
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    var pieDataEntries = [PieChartDataEntry]()
    var dataPoints:[String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
    var barDataEntriesOfEvents = [BarChartDataEntry]()
    var barDataEntriesOfSubEvents = [BarChartDataEntry]()
    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
    
    func updatePieChartData(){
        pieDataEntries.removeAll()
        for category in categories{
            var numOfEvent = 0
            var isInCategory = false
            let dataEntry = PieChartDataEntry()
            for i in 0..<category.eventsInCategory.count {
                let dCalendar = Calendar.current.dateComponents([.year, .month], from: category.eventsInCategory[i].eventDday)
                if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
                    numOfEvent += 1
                    isInCategory = true
                }
            }
            
            if isInCategory == true {
                dataEntry.value = Double(numOfEvent)
                dataEntry.label = category.categoryName
                pieDataEntries.append(dataEntry)
            }
        }
    }
    
    func updateBarChartData(){
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {
          categories = api.callCategory()
          events = api.callEvent()
          tableView.reloadData()
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension GraphViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let format = NumberFormatter()
        format.numberStyle = .none
        format.zeroSymbol = "";
        
        let formatter = DefaultValueFormatter(formatter: format)
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeCell
//
//            cell.badgeLabel.text = semiSection[0]
//            cell.allButton.titleLabel!.text = semiSection[1]
//
//            return cell
//        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatternCell", for: indexPath) as! PatternCell

            cell.patternLabel.text = semiSection[2]
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDegreeCell", for: indexPath) as! CompleteDegreeCell

            cell.completeLabel.text = semiSection[3]
            updateBarChartData()
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
            cell.barChartView.xAxis.axisMaximum = Double(0) + gg * Double(12)
            barChartData.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
            cell.barChartView.notifyDataSetChanged()
//            let legend = cell.barChartView.legend
//            legend.enabled = true
//            legend.horizontalAlignment = .right
//            legend.verticalAlignment = .top
//            legend.orientation = .vertical
//            legend.drawInside = true
//            legend.yOffset = 10.0;
//            legend.xOffset = 10.0;
//            legend.yEntrySpace = 0.0;
            cell.barChartView.xAxis.gridColor = .clear
            cell.barChartView.xAxis.labelPosition = .bottom
            cell.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
            cell.barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
            cell.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            cell.barChartView.rightAxis.enabled = false
            cell.barChartView.data = barChartData
            
            return cell
        }

    }

    
}

//
//
//extension GraphViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        cell.categoryNameLabel.text = categories[indexPath.row].categoryName
//        cell.eventNumLabel.text = String(categories[indexPath.row].eventsInCategory.count)
//
//        return cell
//
//    }
//
//
//}
