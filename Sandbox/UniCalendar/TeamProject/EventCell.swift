//
//  EventCell.swift
//  TeamProject
//
//  Created by KM on 2021/01/07.
//

import UIKit

class EventCell: UITableViewCell {
    

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var dDay: UILabel!
    
    @IBOutlet weak var importance: UILabel!
    @IBOutlet weak var importanceImage: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
