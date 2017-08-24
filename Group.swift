//
//  Group.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/23/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

//class GroupChat: NSObject {
//    var key: String? // whats key mean
//    var title: String? // vendors can name a chat
//    var usersListInChat = [String: Any]() // the people in chat
//    
//    
//    private static var _current : GroupChat? {
//        didSet {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startChat"), object: nil)
//            NotificationCenter.default.post(name: Notification.Name(rawValue: "getNotesList"), object: nil)  // whats notes list?
//        }
//    }
//    
//    static var current: GroupChat? {
//        guard let currentGroupChat = _current else {
//            return nil
//        }
//        return currentGroupChat
//    }
//    
//    init(key: String, title: String, usersListInChat: [String: Any]) {
//        self.key = key
//        self.title = title
//        self.usersListInChat = usersListInChat
//    }
//    
//    init?(snapshot: DataSnapshot) {
//        guard let dict = snapshot.value as? [String: Any],
//            let title = dict["title"] as? String,
//            let usersInChat = dict["usersInChat"] as? [String:String]
//            else {return nil}
//        
//        self.key = snapshot.key
//        self.title = title
//        self.usersListInChat = usersInChat
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        guard let key = aDecoder.decodeObject(forKey: Constants.UserDefaults.key) as? String,
//            let title = aDecoder.decodeObject(forKey: Constants.UserDefaults.title) as? String,
//            let usersListInChat = aDecoder.decodeObject(forKey: Constants.UserDefaults.usersListInChat) as? [String: Any]
//            else { return nil }
//        
//        self.key = key
//        self.title = title
//        self.usersListInChat = usersListInChat
//        super.init()
//    }
//    
//    class func setCurrentChat(_ groupChat: GroupChat, writeToUserDefaults: Bool = false) {
//        if writeToUserDefaults {
//            let data = NSKeyedArchiver.archivedData(withRootObject: groupChat)
//            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentChat)
//        }
//        _current = groupChat
//    } // ^^??
//}
//
//extension GroupChat: NSCoding {
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(key, forKey: Constants.UserDefaults.key)
//        aCoder.encode(title, forKey: Constants.UserDefaults.title)
//        aCoder.encode(usersListInChat, forKey: Constants.UserDefaults.usersListInChat)
//    }
//}
//
//
//
//
//
