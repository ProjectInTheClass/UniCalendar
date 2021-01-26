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
    let firstSentence : [String] = ["로 오늘 일정을 시작해봐요!😄\n현재 ", ", 이제 시작할 사람?🙋🏻\n이제 ", "을/를 오늘 시작하는건 어때요?📢\n벌써 ", ", 오늘 끝내보는 건 어때요?👊🏻\n이제 ", "을/를 해보는 건 어떨까요?🤗\n벌써 ", "을/를 미뤄왔나요⁉️ 이젠 정말 시작해요!🤸🏻‍♀️\n현재 ", ", 얼른 끝내버리자구요🙆\n이제 ", "로 목표의 끝을 향해 달려🏃보는 건 어때요?\n    벌써", "👈🏻을/를 오늘 끝내봐요!\n벌써"]
    let secondSentence: [String] = ["을 완료했어요!👏🏻 곧 끝낼 수 있을 것 같은데요?!", "나 완료한 상태에요😁 결과는 노력을 배신하지 않는대요. 조금만 더!!🔥", "을 해결했어요!😲 이제 목표 완료를 위해 화이팅!💪🏻", "을 한 상태에요🤩 얼른 으쌰으쌰 끝내봐요👌🏻", "나 완료했으니, 4.5는 거뜬할 거 같은데요?😉 조금만 더 힘내요!👍", "나 해결하다니, 멋져요☺️ 오늘도 힘내서 하루를 시작해봐요👊🏻", "나 했어요!👏🏻 조금만 더 하면 100%도 금방일 것 같은데요?🙆‍♂️"]
}

struct LateMiddle {
    let firstSentence : [String] = ["로 하루 일정을 시작해 보는건 어때요?💁\n벌써 ", ", 오늘 끝낼 사람?🙋🏻\n어느덧 ", "을/를 끝내야 하지 않나요?!💥\n이제 ", ", 오늘 마무리하는 건 어떨까요?🧑‍🏫\n벌써 ", "을/를 해보는 건 어떨까요?🤔\n현재 ", "을/를 끝내면 100%에 한 발짝🐾 더 다가갈 수 있어요!\n어느덧 ", "로 오늘을 멋지게😎 마무리해보는 건 어떤가요?\n이제 ", ", 얼른 끝내버려요!🏃\n벌써 "]
    let secondSentence: [String] = ["나 완료했어요!🎊 이 기세라면 금방 마무리하겠는걸요?🙆", "을 해냈어요!🙊 이제 100%가 정말 고지네요 화이팅!🔥", "을 한 상탠데요?! 대단해요 곧 마무리네요!👍🏻", "나 해결하다니😲, 조금만 더 힘내면 좋은 결과가 있을거에요!💯", "나 했어요!🎉 4.5가 조금 더 가까워진 것 같지 않나요?🤓", "나 완료하다니, 마음가짐이 너무 멋져요👊🏻 오늘도 목표의 끝을 향해 달려요!🏃🏻‍♂️", "을 완료했어요! 꾸준히 노력하는 모습이 너무 멋져요☺️💕"]
}

struct End {
    let firstSentence : [String] = [" 끝내고 목표를 다 끝내보자구요!😎\n벌써 ", ", 오늘 끝내고 100% 마무리 해봐요!💯\n어느덧 ", "을/를 하고 이제 마무리하는 건 어때요?🤘🏻\n이제 ", "로 하루를 시작해 보는 건 어때요?🙆🏻\n벌써 ", ", 얼른 끝내버리자구요!💡\n이제 ", ", 오늘 마무리하는 건 어때요?🤸🏻‍♀️\n벌써 ", "을/를 끝내면 이제 곧 100%!🎖\n어느덧 ", "로 목표의 마무리로 달려요!🏃🏻\n벌써 ", "로 오늘 일정을 시작해봐요!😆\n이제 "]
    let secondSentence: [String] = ["나 완료했어요!🎉 곧 모두 완료하겠는걸요?🙌🏻", "나 끝냈어요!👍🏻 조금만 더 힘내면 좋은 결과는 금방이에요!🔥", "을 해결하다니, 대단해요!🙆🏻 이제 마무리가 고지에요!👏🏻", "나 했어요!🤩 4.5도, 100%도 눈 앞에!!🏆", "나 해결했어요!✨ 오늘도 당신의 꿈과 목표를 향해 화이팅🧚🏻‍♂️", "나 완료했어요!🙊 너무 멋있어요 조금만 더 화이팅해요!💪🏻"]
}







