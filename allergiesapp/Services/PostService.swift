//
//  PostService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/8/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase
// used makestagrams user struct syntax

struct PostService {
    static func findPost(forUID uid: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("Posts").child(uid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(post)
        })
    }
    
    static func createPost(forUID uid: String, question: String, tags: String, company: String, completion: @escaping (Post?) -> Void) {
      
        let postAttrs = ["question": question, "tags": tags, "company": company]
        
        let ref = Database.database().reference().child("Posts").child(uid).childByAutoId()
        
        ref.updateChildValues(postAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                print("failed")
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let post = Post(snapshot: snapshot)
                completion(post)
            })
        }
    }
}
