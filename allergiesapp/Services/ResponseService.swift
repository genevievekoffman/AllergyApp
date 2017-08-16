//
//  ResponseService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/15/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct ResponseService {
    
    static func saveResponse(forUID uid: String, response: String, completion: @escaping (Response?) -> Void) {
        
        let responseAttrs = ["response": response]
        
        let ref = Database.database().reference().child("UsersResponse").child(uid).childByAutoId()
        let ref2 = Database.database().reference().child("AllResponse").childByAutoId()
        
        ref2.updateChildValues(responseAttrs) { (error, ref2) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                let response = Response(snapshot: snapshot)
                completion(response)
            })
        }
        
        ref.updateChildValues(responseAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                print("failed")
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let response = Response(snapshot: snapshot)
                completion(response)
            })
        }
    }
}
// created 
