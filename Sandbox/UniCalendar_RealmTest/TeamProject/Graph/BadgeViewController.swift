//
//  BadgeViewController.swift
//  UniCalendar
//
//  Created by Nayeon Kim on 2021/02/10.
//

import UIKit

class BadgeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events = api.callEvent()
    
    var countEvents: Int = -3
    var countCompleteEvents: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeTableViewCell", for: indexPath) as! BadgeTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.image1.image = UIImage(named: "처음_깔았을_때")
            cell.text1.text = "첫 다운로드"
            cell.text2.text = "첫 목표 등록"
            cell.text3.text = "첫 목표 완료"
            
            switch countEvents {
            case -3...0:
                cell.image2.image = UIImage(named: "잠금")
            default:
                cell.image2.image = UIImage(named: "처음_일정_등록했을_때")
            }
            
            switch countCompleteEvents {
            case 0:
                cell.image3.image = UIImage(named: "잠금")
            default:
                cell.image3.image = UIImage(named: "처음_일정_끝냈을_때")
            }

        case 1:
            cell.text1.text = "목표 등록 15개"
            cell.text2.text = "목표 성공 10개"
            cell.text3.text = "목표 등록 30개"
            
            switch countEvents {
            case -3...14:
                cell.image1.image = UIImage(named: "잠금")
                cell.image3.image = UIImage(named: "잠금")
            case 15...29:
                cell.image1.image = UIImage(named: "일정_등록_15개")
                cell.image3.image = UIImage(named: "잠금")
            default:
                cell.image1.image = UIImage(named: "일정_등록_15개")
                cell.image3.image = UIImage(named: "일정_등록_30개")
            }
            
            switch countCompleteEvents {
            case 0...9:
                cell.image2.image = UIImage(named: "잠금")
            default:
                cell.image2.image = UIImage(named: "목표_성공_10개")
            }
            
        case 2:
            cell.text1.text = "목표 성공 20개"
            cell.text2.text = "목표 등록 45개"
            cell.text3.text = "목표 성공 30개"
            
            switch countCompleteEvents {
            case 0...19:
                cell.image1.image = UIImage(named: "잠금")
                cell.image3.image = UIImage(named: "잠금")
            case 20...29:
                cell.image1.image = UIImage(named: "목표_성공_20개")
                cell.image3.image = UIImage(named: "잠금")
            default:
                cell.image1.image = UIImage(named: "목표_성공_20개")
                cell.image3.image = UIImage(named: "목표_성공_30개")
            }
            
            switch countEvents {
            case -3...44:
                cell.image2.image = UIImage(named: "잠금")
            default:
                cell.image2.image = UIImage(named: "일정_등록_45개")
            }
            
        case 3:
            cell.text1.text = "목표 등록 70개"
            cell.text2.text = "목표 성공 40개"
            cell.text3.text = "목표 등록 100개"
            
            switch countEvents {
            case -3...69:
                cell.image1.image = UIImage(named: "잠금")
                cell.image3.image = UIImage(named: "잠금")
            case 70...99:
                cell.image1.image = UIImage(named: "일정_등록_70개")
                cell.image3.image = UIImage(named: "잠금")
            default:
                cell.image1.image = UIImage(named: "일정_등록_70개")
                cell.image3.image = UIImage(named: "일정_등록_100개")
            }
            
            switch countCompleteEvents {
            case 0...39:
                cell.image2.image = UIImage(named: "잠금")
            default:
                cell.image2.image = UIImage(named: "목표_성공_40개")
            }
            
        case 4:
            cell.text1.text = "목표 성공 50개"
            cell.text2.text = "잠금"
            cell.text3.text = "잠금"
            
            switch countCompleteEvents {
            case 0...49:
                cell.image1.image = UIImage(named: "잠금")
            default:
                cell.image1.image = UIImage(named: "목표_성공_50개")
            }
            
            //badge on progress
            //임시로 lock 걸어둠
            cell.image2.image = UIImage(named: "잠금")
            cell.image3.image = UIImage(named: "잠금")
            
        default:
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "업적을 이루고 배지🎖를 모아보세요!"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        countTotal()
        countComplete()
        
        events = api.callEvent()
    }
    
    func countTotal(){
        for _ in events {
            countEvents += 1
        }
    }

    func countComplete() {
        for event in events{
            if event.eventIsDone == true {
                countCompleteEvents += 1
            }
        }
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
