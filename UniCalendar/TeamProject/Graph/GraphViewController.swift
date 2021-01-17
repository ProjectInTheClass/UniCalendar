//
//  GraphViewController.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/17.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let semiSection : [String] = ["배지🎖", "전체 보기▶️", "대학 생활 패턴 분석🔍", "완료도 분석📊"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteDegreeCell", for: indexPath) as! CompleteDegreeCell
            return cell
        }
    
    }
    
}
