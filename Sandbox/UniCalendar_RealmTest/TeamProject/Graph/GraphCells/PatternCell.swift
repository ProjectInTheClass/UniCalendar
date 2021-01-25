//
//  PatternCell.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/17.
//

import UIKit
import Charts

class PatternCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var categories : [Category] = api.callCategory()
    var events: [Event] = api.callEvent()
    
    @IBOutlet weak var patternLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    
//    func setDataSourceAndDelegate(source: UICollectionViewDelegate & UICollectionViewDataSource, row: Int) {
//        self.collectionView.dataSource = source
//        self.collectionView.delegate = source
//        self.collectionView.tag = row
//        self.collectionView.reloadData()
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.categoryNameLabel.text = categories[indexPath.row].categoryName
        cell.eventNumLabel.text = String(categories[indexPath.row].eventsInCategory.count) + " 개 "
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 70, height: 90)
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
