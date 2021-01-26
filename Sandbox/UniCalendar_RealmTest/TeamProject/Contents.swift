//
//  Contents.swift
//  TeamProject
//
//  Created by Nayeon Kim on 2021/01/26.
//

import Foundation

class Content {
    
    static let CONTENT = Content()
    
//    var firstSentences: [String] = []
//    var secondSentences: [String] = []
    
    func makeContent(selected: [String], subEventName: String, percentage: Int) -> String {
        let firstSentence : String = selected.randomElement()!
        let secondSentence : String = selected.randomElement()!
        //let thirdSentence : String = beginnng.randomElement()!
        
        let finalSentence: String = subEventName + firstSentence + "\(percentage)%" + secondSentence
        
        return finalSentence
    }
}

//Content.CONTENT.makeContent(selected: Beginning, subEventName: <#T##String#>, percentage: <#T##Int#>)

class Beginning: Content {
    let firstSentence : [String] = []
    let secondSentence: [String] = []
}

class EarlyMiddle: Content {
    let firstSentence : [String] = []
    let secondSentence: [String] = []
}

class LateMiddle: Content {
    let firstSentence : [String] = []
    let secondSentence: [String] = []
}

class End: Content {
    let firstSentence : [String] = []
    let secondSentence: [String] = []
}

