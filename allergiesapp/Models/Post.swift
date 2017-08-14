//
//  Post.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/8/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    let postURL: String //?? 
    
    let response: String
    let question: String
    let tags: String
    let company: String
    let uid: String
    
//    let poster: User
    
    var dictvalue: [String: Any] {
//        let userdict = ["uid" : poster.uid,
//                        "username" : poster.username]
        return ["postURL": postURL, "response": response, "question": question, "tags": tags, "company": company]
    }
    
    init(uid: String, postURL: String, response: String, question: String, tags: String, company: String) {
        self.uid = uid
        self.postURL = postURL
        self.response = response
        self.question = question
        self.tags = tags
        self.company = company
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            
            let postURL = dict["post_url"] as? String,
//            let userDict = dict["poster"] as? [String: Any], 
            let response = dict["response"] as? String,
            let question = dict["question"] as? String,
            let tags = dict["tags"] as? String,
            let company = dict["company"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.postURL = postURL
        self.company = company
        self.question = question
        self.tags = tags
        self.response = response

    }
}
