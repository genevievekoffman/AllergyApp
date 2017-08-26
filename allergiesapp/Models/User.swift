//
//  User.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/3/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class User: NSObject {
    
    private static var _current: User?
    
    static var current: User {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        return currentUser
    } // creats a private var to hold current user. Cant be accessed outside this class (private). create a var that has a getter that can access the private _current. check if _current is type User? if it is nil - code crashes. if _current has a value, returns to user.
    // Creates setter method to set the current user. after it is set it will remain in memory for the rest of apps lifecycle
    
    let uid: String
    let username: String
    let email: String
    let name: String
    
    var dictValue: [String: Any] {
        return ["username" : username, "name" : name, "email" : email]
    }
    
    init(uid: String, username: String, email: String, name: String) {
        self.uid = uid
        self.username = username
        self.email = email
        self.name = name
        
        super.init()
    }
    
    init?(snapshot: DataSnapshot) { // retrieving from firebase
        guard let dict = snapshot.value as? [String : Any],
            
        let username = dict["username"] as? String,
        let email = dict["email"] as? String,
        let name = dict["name"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        self.email = email
        self.name = name
        
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String,
            let email = aDecoder.decodeObject(forKey: Constants.UserDefaults.email) as? String,
            let name = aDecoder.decodeObject(forKey: Constants.UserDefaults.name) as? String
            else { return nil }
    
        self.uid = uid
        self.username = username
        self.email = email
        self.name = name
        
        super.init()
    } // ^^ retrieves the uid, username, email, and name for the user 
    // NScoding protocol^^ allows users to be decoded from data
    
    class func setCurrent(_ User: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            let data = NSKeyedArchiver.archivedData(withRootObject: User)
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        _current = User
    } // new parameter that takes a bool - whether user should be written to UserDefaults. if true, user object is written to UserDefaults. < NSKeyedArchive > turns user into data, store data with correct key
    
    class func clearCurrent(){
        UserDefaults.standard.removeObject(forKey: "currentUser")
        _current = nil
    }
    
    
    
    
} // whenever user signs up or logs in, user is stored in UserDefaults

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
        aCoder.encode(email, forKey: Constants.UserDefaults.email)
        aCoder.encode(name, forKey: Constants.UserDefaults.name)
    }
}

