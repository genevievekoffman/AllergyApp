//
//  Constants.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/3/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import Foundation
import Firebase

struct Constants {

    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
        static let email = "email"
        static let name = "name"
        
        
        static let key = "key"
        static let title = "title"
        static let usersListInChat = "usersListInChat"
        
        static let chat = "chat"
        static let currentChat = "currentChat" // do I need to add in vendors 
    }
    
    struct VendorDefaults {
        static let currentVendor = "currentVendor"
        static let vendoruid = "vendoruid"
        static let username = "username"
        static let email = "email"
        static let companyName = "companyName"
    }
    
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
    
}
