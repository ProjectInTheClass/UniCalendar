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
    //@IBOutlet weak var importanceImageLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    @IBOutlet weak var importanceOne: UIImageView!
    @IBOutlet weak var importanceTwo: UIImageView!
    @IBOutlet weak var importanceThree: UIImageView!
    @IBOutlet weak var importanceFour: UIImageView!
    @IBOutlet weak var importanceFive: UIImageView!
    
//    let importanceImage: [UIImage] = [UIImage.init(named: "")]
    
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
