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
    static func create(_ firUser: FIRUser, username: String, name: String, email: String, completion: @escaping (User?) -> Void){
        // only when a users username is created can the code move on ^^
        
        let userAttrs = ["username": username, "name": name, "email": email] // creating dictionary with username and name of user
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
        } // func^^ takes the name, username and saves it in database
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
