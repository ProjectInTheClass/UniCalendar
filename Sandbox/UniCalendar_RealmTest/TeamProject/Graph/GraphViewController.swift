import UIKit
import Charts

class GraphViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var barChartView: BarChartView!
    
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    var pieDataEntries = [PieChartDataEntry]()
    var dataPoints:[String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
    var barDataEntries = [BarChartDataEntry]()
    
//    var numbers: [Double] = [] // 차트를 그릴 데이터의 배열
    
    let semiSection : [String] = ["배지🎖", "전체 보기▶️", "대학 생활 패턴 분석🔍", "완료도 분석📊"]
    
    func updatePieChartData(){
        pieDataEntries.removeAll()
        for category in categories{
            let dataEntry = PieChartDataEntry()
            dataEntry.value = Double(category.eventsInCategory.count)
            dataEntry.label = category.categoryName
            pieDataEntries.append(dataEntry)
        }
    }

    
    func updateBarChartData(){
        var numOfCompletedEvents = [Int](repeating: 0, count: 12)
        let year = Calendar.current.component(.year, from: Date.init())
        barDataEntries.removeAll()
        
        for i in 0...11 {
            for event in events{
                let components = Calendar.current.dateComponents([.year, .month], from: event.eventDday)
                if (year == components.year) && ((i + 1) == components.month){
                    numOfCompletedEvents[i] += 1
                }
            }
            let dataEntry = BarChartDataEntry(x: Double(i), y : Double(numOfCompletedEvents[i]))
            barDataEntries.append(dataEntry)
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }


}

extension GraphViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let valFormatter = NumberFormatter()
//        valFormatter.numberStyle = .currency
//        valFormatter.maximumFractionDigits = 2
//        valFormatter.currencySymbol = "$"
                
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeCell

            cell.badgeLabel.text = semiSection[0]
            cell.allButton.titleLabel!.text = semiSection[1]

            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatternCell", for: indexPath) as! PatternCell

            cell.patternLabel.text = semiSection[2]
            
        
            updatePieChartData()
            
            print(pieDataEntries)
            
            let pieChartDataSet = PieChartDataSet(entries: pieDataEntries, label: nil)
            let pieChartData = PieChartData(dataSet: pieChartDataSet)

            print(pieChartData)
            var colors:[UIColor] = []

            for category in categories{
                let color = calculateColor(color: category.categoryColor)

                colors.append( UIColor(named: color)! )
            }
            pieChartDataSet.colors = colors as! [NSUIColor]

            
            pieChartData.setValueFormatter(formatter)
            
            cell.pieChartView.data = pieChartData
            
            cell.pieChartView.data = pieChartData
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDegreeCell", for: indexPath) as! CompleteDegreeCell

            cell.completeLabel.text = semiSection[3]
            updateBarChartData()
            let barChartDataSet = BarChartDataSet(entries: barDataEntries, label: "완료 목표 수")
            let barChartData = BarChartData(dataSet: barChartDataSet)
        
            
            barChartData.setValueFormatter(formatter)
            barChartDataSet.colors = [UIColor(named: "purple")!] as! [NSUIColor]
            
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

//import UIKit
//import RealmSwift
//
//class GraphViewController: UIViewController {
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}
