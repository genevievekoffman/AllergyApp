//
//  LiveChatService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/23/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseDatabase


// struct LiveChatService {
// DIFFERENT BECAUSE I DONT HAVE CLASSES/COURSES
//    
//    static func createNewLiveChat(newTitle: String, completion: @escaping (GroupChat?) -> Void) {
//        if newTitle.isEmpty {
//            completion (nil)
//            return
//        }
//        let refNewLiveChat = Database.database().reference().child("LiveChat").childByAutoId()
//        let NewLiveChatKey = refNewLiveChat.key
//        
//        let dict: [String: Any] = ["title": newTitle, "usersInChat": [User.current.uid: User.current.username] ]
//        let chatDict = ["name" : newTitle] // ???
//        
//        let updatedData: [String: Any] = ["LiveChat/\(NewLiveChatKey)": dict, "chats/\(NewLiveChatKey)": chatDict, "users/\(NewLiveChatKey)": newTitle ]
//        // does this create multiple ref? what does chats/newlivechatkey chat dict do? and the last one
//        Database.database().reference().updateChildValues(updatedData) {(error,ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return completion(nil)
//            }
//            refNewLiveChat.observeSingleEvent(of: .value, with: {(snapshot) in
//                let chat = GroupChat(snapshot: snapshot)
//            completion(chat)
//            })
//        }
//    }
//    
//    
//    
//    
//    
//}

