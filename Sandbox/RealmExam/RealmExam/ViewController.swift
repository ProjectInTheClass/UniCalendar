//
//  ViewController.swift
//  RealmExam
//
//  Created by 김준경 on 2021/01/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        realm.begzinWrite()
//     
//        realm.delete(realm.objects(Person.self))
//        try! realm.commitWrite()
//        
//        save()
        
        render()
        
    }
    
    func render(){
        let people = realm.objects(Person.self)
        for person in people {
            let firstName = person.firstName
            let lastName = person.lastName
            let fullName = "\(firstName) \(lastName)"
            
            print("\(fullName)")
            
        }
    }
    
    func save(){
        let joe = Person()
        joe.firstName = "Jenny"
        joe.lastName = "S"
        
        realm.beginWrite()
        realm.add(joe)
        try! realm.commitWrite()
        
    }


}

class Person: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var age: Int = 0
}
