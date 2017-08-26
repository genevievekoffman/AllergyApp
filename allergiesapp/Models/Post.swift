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
    
    
    
    let question: String
    let tags: String
    let company: String
    let userID: String
    
    let postID: String?
    

    
    var dictvalue: [String: Any] {

        return [  "question": question, "tags": tags, "company": company, "userID": userID]
    }
    
    init(postID: String,  question: String, tags: String, company: String, userID: String) {
        self.postID = postID
        
        
        self.question = question
        self.tags = tags
        self.company = company
        self.userID = userID
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
            
            let userID = dict["userID"] as? String, // added userID
            let question = dict["question"] as? String,
            let tags = dict["tags"] as? String,
            let company = dict["company"] as? String
            else { return nil }
        
        self.postID = snapshot.key
        
        self.company = company
        self.question = question
        self.tags = tags
        self.userID = userID // added -> saves current user as the userID changes it to username
        

    }
}
