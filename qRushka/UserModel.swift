//
//  UserModel.swift
//  qRushka
//
//  Created by User on 22.11.2021.
//

import Foundation


fileprivate let path:String = "http://www.bashni.org/sites/iphone/corona/qr.php?name="


struct UserModel {
    let keyValid = "keyValid"
    let keyString = "keyString"
    let userDefaults = UserDefaults.standard
    var user: User
 
    mutating func updateUser(name:String,
                    birth:String,
                    pass:String) {
        let d = "_"
        let temp = name+d+birth+d+pass
        self.user = User(isValid: true, string: temp )
        userDefaults.set(true, forKey: keyValid)
        userDefaults.set(temp, forKey: keyString)
    }

    mutating func updateUser(string:String) {
        self.user = User(isValid: true, string: string )
        userDefaults.set(true, forKey: keyValid)
        userDefaults.set(string, forKey: keyString)
    }

    
    mutating func cleanUser() {
        self.user = User(isValid: false, string: "")
        userDefaults.set(false, forKey: keyValid)
    }
    
    init() {
        if userDefaults.value(forKey: keyValid) == nil { // 1
            userDefaults.set(false, forKey: keyValid) // 2
        }

        if userDefaults.value(forKey: keyString) == nil {
            userDefaults.set("", forKey: keyString)
        }

        self.user = User(isValid: userDefaults.bool(forKey: keyValid), string: userDefaults.string(forKey: keyString) ?? "")
        
    }
        

    struct User {
        var isValid:Bool
        var string:String

        init(isValid:Bool, string:String) {
            self.isValid = isValid
            self.string = string
        }
        
        func genUrl()->String {
            return path+self.string
        }
    }
}


struct Web: Decodable {
    var id: Int
    var web: String
}


