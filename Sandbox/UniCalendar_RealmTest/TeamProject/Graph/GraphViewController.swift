import UIKit
import Charts

class GraphViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var barChartView: BarChartView!
    
    let categories : [Category] = api.callCategory()
    let events: [Event] = api.callEvent()
    var pieDataEntry = PieChartDataEntry(value: 0)
    var numberOfPieDataEntries = [PieChartDataEntry]()
    
//    var numbers: [Double] = [] // 차트를 그릴 데이터의 배열
    
    let semiSection : [String] = ["배지🎖", "전체 보기▶️", "대학 생활 패턴 분석🔍", "완료도 분석📊"]
    
//    func updatePieChartData(){
//        for category in categories{
//            pieDataEntry.value = Double(category.categoryName.count)
//            pieDataEntry.label = category.categoryName
//
//            numberOfPieDataEntries.append(pieDataEntry)
//        }
////        pieChartView.chartDescription?.text = "생활패턴분석"
//
//        let pieChartDataSet = PieChartDataSet(entries: numberOfPieDataEntries, label: nil)
//        let pieChartData = PieChartData(dataSet: pieChartDataSet)
//
//        var colors:[UIColor] = []
//
//        for category in categories{
//            let color = calculateColor(color: category.categoryColor)
//
//            colors.append( UIColor(named: color)! )
//        }
//        pieChartDataSet.colors = colors as! [NSUIColor]
//
//
//
//
//    }

//    func drawBarCahrt() {
//        var barChartEntry = [ChartDataEntry]() // graph 에 보여줄 data array
//
//         // chart data array 에 데이터 추가
//        for i in 0..<events.count {
//                let value = ChartDataEntry(x: Double(i), y: numbers[i])
//                barChartEntry.append(value)
//         }
//        let line1 = BarChartDataSet(entries: barChartEntry, label: "Number")
//        line1.colors = [NSUIColor.blue]
//
//        let data = LineChartData()
//        data.addDataSet(line1)
//
//
//    }
    
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
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as! BadgeCell

            cell.badgeLabel.text = semiSection[0]
            cell.allButton.titleLabel!.text = semiSection[1]

            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatternCell", for: indexPath) as! PatternCell

            cell.patternLabel.text = semiSection[2]
//            cell.pieChartView.data = pieChartData
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDegreeCell", for: indexPath) as! CompleteDegreeCell
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
