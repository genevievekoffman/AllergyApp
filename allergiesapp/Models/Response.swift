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
    let responseURL : String
    let uid: String
    let response : String
    
    
    var dictValue: [String: Any] {
        return ["responseURL" : responseURL, "response" : response]
    }
    
    init(uid: String, responseURL: String, response: String) {
        self.uid = uid
        self.responseURL = responseURL
        self.response = response
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            let responseURL = (dict["response_url"] ?? "") as? String,
            let response = (dict["response"] ?? "") as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.responseURL = responseURL
        self.response = response 
    }
}
// created 
