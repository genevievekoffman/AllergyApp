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
    
    static func recieveAllResponse(forUID uid: String, postID: String, completion: @escaping ([Response]?) -> Void) {
        
        let ref = Database.database().reference().child("AllResponse").child(postID)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else {
                    return completion([]) }
            
            var arrayOfAllResponses = [Response]()
            
            print(snapshot)
            for postSnap in snapshot {
                print(postSnap)
                guard let response = Response(snapshot: postSnap)
                    else { return completion([]) }
                
                arrayOfAllResponses.append(response) }
            
            completion(arrayOfAllResponses)
        })
    }
    
    
    static func saveResponse(forUID uid: String, response: String, usernameID: String, postID: String, completion: @escaping (Response?) -> Void) {
        
        let responseAttrs = ["response": response, "usernameID": usernameID]
        
        let ref = Database.database().reference().child("UsersResponse").child(User.current.uid).childByAutoId()
        let ref2 = Database.database().reference().child("AllResponse").child(postID).childByAutoId()
        
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
    
    static func saveVendorResponse(forUID uid: String, response: String, vendorID: String, postID: String, completion: @escaping (Response?) -> Void) {
        
        let responseAttrs = ["response": response, "vendorID": vendorID]
        
        let ref = Database.database().reference().child("VendorsResponse").child(Vendor.current.vendoruid).childByAutoId()
        let ref2 = Database.database().reference().child("AllResponse").child(postID).childByAutoId()
        
        ref2.updateChildValues(responseAttrs) { (error, ref2) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
        }
        
        ref.updateChildValues(responseAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                print("failed")
                return completion(nil)
            }
        }
    }
}

