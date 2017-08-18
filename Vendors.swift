//
//  Vendors.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/18/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot


class Vendor: NSObject {
    
    private static var _current: Vendor? // current Vendor 
    
    static var current: Vendor {
        guard let currentVendor = _current else {
            fatalError("Error: current user doesn't exist")
        }
        return currentVendor
    }
    
    let vendoruid: String
    let username: String
    let companyName: String
    let email: String
    // let verified: Bool // 5 numbers - backup to passcode
   
    var dictValue: [String: Any] {
        return ["username" : username, "companyName" : companyName, "email" : email]
    }
    
    init(vendoruid: String, username: String, companyName: String, email: String) {
        self.vendoruid = vendoruid
        self.username = username
        self.companyName = companyName
        self.email = email
    
        
        super.init()
    }
    
    init?(snapshot: DataSnapshot) { // retrieving from firebase
        guard let dict = snapshot.value as? [String : Any],
            
            let username = dict["username"] as? String,
            let companyName = dict["companyName"] as? String,
            let email = dict["email"] as? String
            else { return nil }
        
        self.vendoruid = snapshot.key
        self.username = username
        self.companyName = companyName
        self.email = email
        
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        guard let vendoruid = aDecoder.decodeObject(forKey: Constants.VendorDefaults.vendoruid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.VendorDefaults.username) as? String,
            let email = aDecoder.decodeObject(forKey: Constants.VendorDefaults.email) as? String,
            let companyName = aDecoder.decodeObject(forKey: Constants.VendorDefaults.companyName) as? String
            else { return nil }
        
        self.vendoruid = vendoruid
        self.username = username
        self.email = email
        self.companyName = companyName
        
        super.init()
    }
    
    class func setCurrent(_ Vendor: Vendor, writeToVendorDefaults: Bool = false) {
        if writeToVendorDefaults {
            let data = NSKeyedArchiver.archivedData(withRootObject: Vendor)
            UserDefaults.standard.set(data, forKey: Constants.VendorDefaults.currentVendor)
        }
        _current = Vendor
    }
}

extension Vendor: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(vendoruid, forKey: Constants.VendorDefaults.vendoruid)
        aCoder.encode(username, forKey: Constants.VendorDefaults.username)
        aCoder.encode(email, forKey: Constants.VendorDefaults.email)
        aCoder.encode(companyName, forKey: Constants.VendorDefaults.companyName)
    }
}
