//
//  AllergyService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/16/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct AllergyService {
    
    static func saveAllergy(forUID uid: String, allergy: String, completion: @escaping (Allergies?) -> Void) {
        let allergyAttrs = ["allergy": allergy]
        
        let ref = Database.database().reference().child("UsersAllergies").child(uid).childByAutoId()
        
        ref.updateChildValues(allergyAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                print("failed")
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let allergy = Allergies(snapshot: snapshot)
                completion(allergy)
            })
        }
    }
}
// created
