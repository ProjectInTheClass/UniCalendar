//
//  Contents.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/26.
//

import Foundation

class Content {
    
    static let CONTENT = Content()
    
    func makeContent(first: [String], second: [String], subEventName: String, percentage: Int) -> String {
        let firstSentence : String = first.randomElement()!
        let secondSentence : String = second.randomElement()!
        //let thirdSentence : String = beginnng.randomElement()!
        
        let finalSentence: String = subEventName + firstSentence + "\(percentage)%" + secondSentence
        
        return finalSentence
    }
    
//    func makeContentForEmptySubEvents() -> String {
//
//    }
}



struct Beginning {
    let firstSentence : [String] = ["로 일정을 시작해 보는 건 어때요?😁\n아직 일정 중 ", "을/를 시작으로 목표를 시작해봐요!💪🏻\n 아직 ", ", 오늘 시작할 사람?🙋🏻\n아직 ", ", 오늘 끝내볼까요?👌🏻\n아직까지 ", "로 목표를 시작해 보는 건 어떨까요?💁\n아직 일정 중", ", 이제 시작해볼까요?🏃\n아직 일정 중", "을/를 오늘 끝내봐요!🌈\n아직 "]
    let secondSentence: [String] = ["밖에 하지 못했어요😯! 얼른 으쌰으쌰 끝내봐요🙆", "만 완료했어요🤔 오늘 할 일도 얼른 시작해봐요!🔥", "만 해결했어요🙌🏻 이제 다른 소목표도 시작해요!🤓", "만 했어요!😅 조금만 더 하면 100%도 코앞이에요🥳", "밖에 하지 못 한 거 같아요👀 우리 조금만 더 힘내서 목표를 완료해볼까요?🤓", "만 해결했어요🥸! 얼른 으쌰으쌰 끝내봐요🔥", "만 완료했어요😲 조금만 더 하면 50%도 코앞이에요👊🏻"]
}

struct EarlyMiddle {
    let firstSentence : [String] = ["로 오늘 일정을 시작해봐요!😄\n현재 ", ", 이제 시작할 사람?🙋🏻\n이제 ", "을/를 오늘 시작하는건 어때요?📢\n벌써 ", ", 오늘 끝내보는 건 어때요?👊🏻\n이제 ", "을/를 해보는 건 어떨까요?🤗\n벌써 ", "을/를 미뤄왔나요⁉️ 이젠 정말 시작해요!🤸🏻‍♀️\n현재 ", ", 얼른 끝내버리자구요🙆\n이제 ", "로 목표의 끝을 향해 달려🏃보는 건 어때요?\n    벌써", "을/를 오늘 끝내봐요!👈🏻\n벌써"]
    let secondSentence: [String] = ["을 완료했어요!👏🏻 곧 끝낼 수 있을 것 같은데요?!", "나 완료한 상태에요😁 결과는 노력을 배신하지 않는대요. 조금만 더!!🔥", "을 해결했어요!😲 이제 목표 완료를 위해 화이팅!💪🏻", "을 한 상태에요🤩 얼른 으쌰으쌰 끝내봐요👌🏻", "나 완료했으니, 4.5는 거뜬할 거 같은데요?😉 조금만 더 힘내요!👍", "나 해결하다니, 멋져요☺️ 오늘도 힘내서 하루를 시작해봐요👊🏻", "나 했어요!👏🏻 조금만 더 하면 100%도 금방일 것 같은데요?🙆‍♂️"]
}

struct LateMiddle {
    let firstSentence : [String] = ["", "", "", "", ""]
    let secondSentence: [String] = ["", "", "", "", ""]
}

struct End {
    let firstSentence : [String] = [" 완료하고 마무리", "", "", "", ""]
    let secondSentence: [String] = ["", "", "", "", ""]
}







