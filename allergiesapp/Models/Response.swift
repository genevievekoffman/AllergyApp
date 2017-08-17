//
//  Response.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/16/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Response{
    
    let responseID: String
    let response : String
    let uid: String
    let usernameID: String
    
    var dictValue: [String: Any] {
        return [ "response" : response, "usernameID": usernameID]
    }
    
    init(uid: String, response: String, responseID: String, usernameID: String) {
        self.responseID = responseID
    
        self.response = response
        self.uid = uid
        self.usernameID = usernameID
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let response = (dict["response"] ?? "") as? String,
            let responseID = (dict["responseID"] ?? "" ) as? String,
            let usernameID = (dict["usernameID"] ?? "") as? String,
            let uid = (dict["uid"] ?? "" ) as? String
            else { return nil }
        self.uid = uid
        self.responseID = snapshot.key
       
        self.response = response
        self.usernameID = User.current.username
    }
}
