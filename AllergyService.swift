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
    
    static func saveMyAllergies(allergy: String, userID: String, completion: @escaping (Allergy?) -> Void) {
        
        let allergyAttrs = ["allergy": allergy]
        
        
        let ref = Database.database().reference().child("Allergies").child(userID).childByAutoId()
            
        ref.updateChildValues(allergyAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                print("failed")
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let allergy = Allergy(snapshot: snapshot)
                completion(allergy)
            })
        }
    }
    
    static func recieveMyAllergies(userID: String, completion: @escaping ([String]?) -> Void) {
        let ref = Database.database().reference().child("Allergies").child(userID)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotArray = snapshot.children.allObjects as? [DataSnapshot]
                else {
                    return completion(nil)
            }
            
            
            var arrayOfActualAllergyStrings = [String]()
            
            print(snapshot)
            
            for postSnap in snapshotArray {
                print(postSnap)
                guard let allergy = Allergy(snapshot: postSnap)
                    else { return completion([]) }
                
                arrayOfActualAllergyStrings.append(allergy.allergyName)
            }
            
            completion(arrayOfActualAllergyStrings)
        })
    }
}
