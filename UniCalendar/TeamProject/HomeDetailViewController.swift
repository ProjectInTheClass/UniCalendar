//
//  HomeDetailViewController.swift
//  TeamProject
//
//  Created by KM on 2021/01/17.
//

import UIKit

class HomeDetailViewController: UIViewController {
  
    var dDay: String = ""
    var eventName: String = ""
    var progressPercent: Float = 0.0
    
    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressPercentLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dDayLabel.text = dDay
        eventNameLabel.text = eventName
        progressView.setProgress(progressPercent, animated: false)
        progressPercentLabel.text = "\(progressPercent*100)%"
    }

}
