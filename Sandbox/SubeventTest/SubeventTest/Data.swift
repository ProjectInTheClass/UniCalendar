//
//  Data.swift
//  SubeventTest
//
//  Created by 김준경 on 2021/01/19.
//

import Foundation
import RealmSwift

class SubEvent: Object {
    @objc dynamic var subEventName: String = ""
    @objc dynamic var subEventIsDone: Bool = false
    
}
