//
//  CalculateBadge.swift
//  UniCalendar
//
//  Created by Nayeon Kim on 2021/02/13.
//

import Foundation

//획득한 배지의 String을 배열로 저장-> 최신순으로 내림차 정렬 되어 있음

//이벤트를 처음 더했을 때 여부를 알기 위해
var firstAdd: Bool = false


func calculateBadge() {
    let badges = api.callBadge()
    let events = api.callEvent()
    let countEvents: Int = events.count
    var countCompleteEvents: Int = 0
    
    for event in events {
        if event.eventIsDone == true {
            countCompleteEvents+=1
        }
    }
    
    var existBadge: Bool = false
    
    switch countEvents {
    case 1...4:
        //이벤트를 처음 추가했을때
        if firstAdd == true && badges.count == 1{
            let newBadge = Badge.init(badgeImageString: "처음_일정_등록했을_때")
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        } else { //이벤트를 아직 추가하지 않았을 때
            break
        }
    case 15:
        let newBadge = Badge.init(badgeImageString:"일정_등록_15개")
        
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
        
    case 30:
        let newBadge = Badge.init(badgeImageString: "일정_등록_30개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 45:
        let newBadge = Badge.init(badgeImageString: "일정_등록_45개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 70:
        let newBadge = Badge.init(badgeImageString: "일정_등록_70개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 100:
        let newBadge = Badge.init(badgeImageString: "일정_등록_100개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    default:
        break
    }
    
    switch countCompleteEvents {
    case 1:
        let newBadge = Badge.init(badgeImageString: "처음_일정_끝냈을_때")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 10:
        let newBadge = Badge.init(badgeImageString: "목표_성공_10개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 20:
        let newBadge = Badge.init(badgeImageString: "목표_성공_20개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 30:
        let newBadge = Badge.init(badgeImageString: "목표_성공_30개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 40:
        let newBadge = Badge.init(badgeImageString: "목표_성공_40개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    case 50:
        let newBadge = Badge.init(badgeImageString: "목표_성공_50개")
        for badge in badges {
            if badge.badgeImageString == newBadge.badgeImageString {
                existBadge = true
            }
        }
        
        if existBadge == true {
            break
        } else {
            try? api.realm.write(){
                api.realm.add(newBadge)
            }
        }
    default:
        break
    }
}
//struct Calculate {
//    func calculateBadge() {
//
//    }
//}
