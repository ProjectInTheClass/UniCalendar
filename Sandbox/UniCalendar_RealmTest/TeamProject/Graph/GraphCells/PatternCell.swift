////
////  PatternCell.swift
////  TeamProject
////
////  Created by Nayeon Kim on 2021/01/17.
////
//
//import UIKit
//import Charts
//
//var isClicked = true
//var flag = true
//
//class PatternCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    @IBOutlet weak var patternLabel: UILabel!
//    @IBOutlet weak var pieChartView: PieChartView!
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    
//    var categories : [Category] = api.callCategory()
//    var events: [Event] = api.callEvent()
//    var pieDataEntries = [PieChartDataEntry]()
//    let today = Calendar.current.dateComponents([.year, .month, .day], from: Date.init())
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        return categories.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
//        
//        if isClicked == false {
//            if flag == true {
//                cell.setLayout()
//            }else{
//                cell.changeLastCollectionView()
//            }
//        }
//        return cell
//    }
//    
//    func drawPieChart() {
//        let format = NumberFormatter()
//        format.numberStyle = .none
//        format.zeroSymbol = "";
//        let formatter = DefaultValueFormatter(formatter: format)
//        pieDataEntries.removeAll()
//        var colors:[UIColor] = []
//
//        for category in categories{
//            let color = calculateColor(color: category.categoryColor)
//
//            colors.append( UIColor(named: color)! )
//        }
//        
//        for category in categories{
//            var numOfEvent = 0
//            var isInCategory = false
//            let dataEntry = PieChartDataEntry()
//            for i in 0..<category.eventsInCategory.count {
//                let dCalendar = Calendar.current.dateComponents([.year, .month], from: category.eventsInCategory[i].eventDday)
//                if ((dCalendar.year == today.year) && (dCalendar.month == today.month)){
//                    numOfEvent += 1
//                    isInCategory = true
//                }
//            }
//            
//            if isInCategory == true {
//                dataEntry.value = Double(numOfEvent)
//                dataEntry.label = category.categoryName
//                pieDataEntries.append(dataEntry)
//                let color = calculateColor(color: category.categoryColor)
//
//                colors.append( UIColor(named: color)! )
//            }
//        }
//        let pieChartDataSet = PieChartDataSet(entries: pieDataEntries, label: nil)
//        let pieChartData = PieChartData(dataSet: pieChartDataSet)
//        
//        pieChartDataSet.colors = colors
//        pieChartData.setValueFormatter(formatter)
//        
//        pieChartView.animate(xAxisDuration: 1.0)
//        pieChartView.data = pieChartData
//    }
//    
//    func drawLastPieChart () {
//        let format = NumberFormatter()
//        format.numberStyle = .none
//        format.zeroSymbol = "";
//        let formatter = DefaultValueFormatter(formatter: format)
//        pieDataEntries.removeAll()
//        for category in categories{
//            var numOfEvent = 0
//            var isInCategory = false
//            let dataEntry = PieChartDataEntry()
//            for i in 0..<category.eventsInCategory.count {
//                let dCalendar = Calendar.current.dateComponents([.year, .month], from: category.eventsInCategory[i].eventDday)
//                if ((dCalendar.year == today.year) && ((dCalendar.month! + 1) == today.month) && today.month != 1) || (((dCalendar.year! + 1) == today.year) && today.month == 1 && dCalendar.month! == 12) {
//                    numOfEvent += 1
//                    isInCategory = true
//                }
//            }
//            
//            if isInCategory == true {
//                dataEntry.value = Double(numOfEvent)
//                dataEntry.label = category.categoryName
//                pieDataEntries.append(dataEntry)
//            }
//        }
//        let pieChartDataSet = PieChartDataSet(entries: pieDataEntries, label: nil)
//        let pieChartData = PieChartData(dataSet: pieChartDataSet)
//
//        var colors:[UIColor] = []
//
//        for category in categories{
//            let color = calculateColor(color: category.categoryColor)
//
//            colors.append( UIColor(named: color)! )
//        }
//        pieChartDataSet.colors = colors
//        pieChartData.setValueFormatter(formatter)
//        
//        pieChartView.animate(xAxisDuration: 1.0)
//        pieChartView.data = pieChartData
//    }
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
//    @IBAction func segDidChanged(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            categories = api.callCategory()
//            events = api.callEvent()
//            numOfCall = 0
//            numOfLastCall = 0
//            drawLastPieChart()
//            isClicked = false
//            flag = false
//            collectionView.reloadData()
//        case 1:
//            categories = api.callCategory()
//            events = api.callEvent()
//            numOfCall = 0
//            numOfLastCall = 0
//            drawPieChart()
//            flag = true
//            collectionView.reloadData()
//        default:
//            break
//        }
//    }
//    
//    func setLayouts() {
//        numOfCall = 0
//        categories = api.callCategory()
//        events = api.callEvent()
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
//        collectionView.reloadData()
//        drawPieChart()
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
//
//}
