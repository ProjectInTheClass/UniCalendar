//
//  EventCell.swift
//  TeamProject
//
//  Created by KM on 2021/01/07.
//

import UIKit

class EventCell: UITableViewCell {
    

//    @IBOutlet weak var eventNameLabel: UILabel!
//    @IBOutlet weak var dDayLabel: UILabel!
//
//    @IBOutlet weak var importanceLabel: UILabel!
//    @IBOutlet weak var importanceImageLabel: UILabel!
//
//    @IBOutlet weak var progressLabel: UILabel!
//    @IBOutlet weak var progressView: UIProgressView!
//    @IBOutlet weak var progressPercentLabel: UILabel!
//
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    
    @IBOutlet weak var importanceLabel: UILabel!
    @IBOutlet weak var importanceImageLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
//    func returnCellIndex() -> Int {
//        print(self.tag)
//        print(self.hashValue)
//        return self.tag
//    }

}
