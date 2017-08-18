//
//  VendorService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/18/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase


struct VendorService {
    static func create(_ firUser: FIRUser, username: String, companyName: String, email: String, completion: @escaping (Vendor?) -> Void){
        // only when a users username is created can the code move on ^^
        
        let vendorAttrs = ["username": username, "companyName": companyName, "email": email]
        let ref = Database.database().reference().child("Vendors").child(firUser.uid) // reference to where it will store the usernames ( a path )
        ref.setValue(vendorAttrs) { (Error, ref) in
            if let error = Error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
                let vendor = Vendor(snapshot: snapshot)
                completion(vendor)
            })
        } // func^^ takes the name, username and saves it in database
    }
    
    static func show(forUID uid: String, completion: @escaping (Vendor?) -> Void) {
        let ref = Database.database().reference().child("Vendor").child(uid)
        ref.observeSingleEvent(of: .value, with: {(snapShot) in
            guard let vendor = Vendor(snapshot: snapShot) else {
                return completion(nil)
            }
            completion(vendor)
        })
    }
}
