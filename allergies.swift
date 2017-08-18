//
//  allergies.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/16/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Allergy {
    
    let allergyName : String
    let userID: String
    
    var dictValue: [String: Any] {
        return ["allergy" : allergyName]
    }
    
    init(userID: String, allergyName: String) {
        self.userID = userID
        self.allergyName = allergyName
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
             let allergyName = dict["allergy"] as? String
            else { return nil }
        
        self.userID = snapshot.key
        self.allergyName = allergyName
    }
}
// created 
// saves an array of allergies 

//let mynewallergies = Allergies(userID: "imsean", allergy: ["peanuts", "walnuts"])
//mynewallergies.allergy
