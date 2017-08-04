//
//  UserService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/3/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void){
        // only when a users username is created can the code move on ^^
        
        let userAttrs = ["username": username] // creating constant for the string value of username
        let ref = Database.database().reference().child("Users").child(firUser.uid) // reference to where it will store the usernames ( a path )
        ref.setValue(userAttrs) { (Error, ref) in // placing the username string in the database location (holds usernames)
            if let error = Error { // if an error does exist
                assertionFailure(error.localizedDescription) // it will print out the error
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: {(snapshot) in //
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    static func create(_ firUser: FIRUser, name: String, completion: @escaping (User?) -> Void) {
        // only when a users name is inserted(label) can the following code run ^^
        
        let userAttrs = ["name": name] // creates constant for string value of name
        let ref = Database.database().reference().child("Users").child(firUser.uid) //explanation above
        ref.setValue(userAttrs) { (Error, ref) in
            if let error = Error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })  // func^^ takes the users name and saves it in database
        }
    }
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("Users").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapShot) in
            guard let user = User(snapshot: snapShot) else {
                return completion(nil)
            }
            completion(user)
        })
    }
}
