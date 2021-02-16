//
//  CalendarEventTableViewCell.swift
//  TeamProject
//
//  Created by 김준경 on 2021/01/22.
//

import UIKit

class CalendarEventTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryColorImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var subCompletionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
