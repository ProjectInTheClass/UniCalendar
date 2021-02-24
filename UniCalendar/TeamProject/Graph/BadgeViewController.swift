//
//  BadgeViewController.swift
//  UniCalendar
//
//  Created by Nayeon Kim on 2021/02/10.
//

import UIKit

class BadgeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var events = api.callEvent()
    var badges = api.callBadge()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeTableViewCell", for: indexPath) as! BadgeTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.image1.image = UIImage(named: "처음_깔았을_때")
            cell.image2.image = UIImage(named: "잠금")
            cell.image3.image = UIImage(named: "잠금")
            
            cell.text1.text = "첫 다운로드"
            cell.text2.text = "첫 목표 등록"
            cell.text3.text = "첫 목표 완료"
            
            for badge in badges {
                if badge.badgeImageString == "처음_일정_등록했을_때" {
                    cell.image2.image = UIImage(named: badge.badgeImageString)
                } else if badge.badgeImageString == "처음_일정_끝냈을_때" {
                    cell.image3.image = UIImage(named: badge.badgeImageString)
                }
            }
            

        case 1:
            cell.image1.image = UIImage(named: "잠금")
            cell.image2.image = UIImage(named: "잠금")
            cell.image3.image = UIImage(named: "잠금")
            
            cell.text1.text = "목표 등록 15개"
            cell.text2.text = "목표 성공 10개"
            cell.text3.text = "목표 등록 30개"
            
            for badge in badges {
                if badge.badgeImageString == "일정_등록_15개" {
                    cell.image1.image = UIImage(named: badge.badgeImageString)
                } else if badge.badgeImageString == "목표_성공_10개" {
                    cell.image2.image = UIImage(named: badge.badgeImageString)
                } else if badge.badgeImageString == "일정_등록_30개"{
                    cell.image3.image = UIImage(named: badge.badgeImageString)
                }
            }
            

        case 2:
            cell.image1.image = UIImage(named: "잠금")
            cell.image2.image = UIImage(named: "잠금")
            cell.image3.image = UIImage(named: "잠금")
            
            cell.text1.text = "목표 성공 20개"
            cell.text2.text = "목표 등록 45개"
            cell.text3.text = "목표 성공 30개"
            
            for badge in badges {
                if badge.badgeImageString == "목표_성공_20개" {
                    cell.image1.image = UIImage(named: badge.badgeImageString)
                } else if badge.badgeImageString == "일정_등록_45개" {
                    cell.image2.image = UIImage(named: badge.badgeImageString)
                } else if badge.badgeImageString == "목표_성공_30개"{
                    cell.image3.image = UIImage(named: badge.badgeImageString)
                }
            }
            
            
        case 3:
            cell.image1.image = UIImage(named: "잠금")
            cell.image2.image = UIImage(named: "잠금")
            cell.image3.image = UIImage(named: "잠금")
            
            cell.text1.text = "목표 등록 70개"
            cell.text2.text = "목표 성공 40개"
            cell.text3.text = "목표 등록 100개"
            
            for badge in badges {
                if badge.badgeImageString == "일정_등록_70개" {
                    cell.image1.image = UIImage(named: badge.badgeImageString)
                } else if badge.badgeImageString == "목표_성공_40개" {
                    cell.image2.image = UIImage(named: badge.badgeImageString)
                } else if badge.badgeImageString == "일정_등록_100개" {
                    cell.image3.image = UIImage(named: badge.badgeImageString)
                }
            }
            

        case 4:
            cell.image1.image = UIImage(named: "잠금")
            cell.image2.image = UIImage(named: "잠금")
            cell.image3.image = UIImage(named: "잠금")
            
            cell.text1.text = "목표 성공 50개"
            cell.text2.text = "잠금"
            cell.text3.text = "잠금"
            
            for badge in badges {
                if badge.badgeImageString == "목표_성공_50개" {
                    cell.image1.image = UIImage(named: badge.badgeImageString)
                }
            }
            
            
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
        badges = api.callBadge()
        events = api.callEvent()
        
        tableView.reloadData()
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
