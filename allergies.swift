//
//  allergies.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/16/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Allergies {
    let allergy : String
    let uid: String
    
    var dictValue: [String: Any] {
        return ["allergy" : allergy]
    }
    
    init(uid: String, allergy: String) {
        self.uid = uid
        self.allergy = allergy
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
             let allergy = (dict["allergy"] ?? "") as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.allergy = allergy
    }
}
// created 
