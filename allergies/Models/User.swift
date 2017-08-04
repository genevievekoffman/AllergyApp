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
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
        
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        
        super.init()
    }
    
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        _current = user
    } // new parameter that takes a bool - whether user should be written to UserDefaults. if true, user object is written to UserDefaults. < NSKeyedArchive > turns user into data, store data with correct key
    
} // whenever user signs up or logs in, user is stored in UserDefaults

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}

