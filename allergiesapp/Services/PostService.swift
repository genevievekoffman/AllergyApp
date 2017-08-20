//
//  PostService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/8/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseAuth.FIRUser
import FirebaseDatabase


struct PostService {
    
    static func retrieveAllPosts(forUID uid: String, completion: @escaping ([Post]?) -> Void) {
        
        let ref = Database.database().reference().child("GeneralPosts")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] // takes snapshot and breaks it down
                else {
                    return completion([]) }
            
            var arrayOfAllPosts = [Post]()
           print(snapshot)
            for postSnap in snapshot {
                print(postSnap)
                guard let post = Post(snapshot: postSnap) // init post with data from snapshot
                    else { return completion([]) }
                arrayOfAllPosts.append(post) }
            
            completion(arrayOfAllPosts)
            
            
        }) // retrieving every post on the app, returns an array of all posts
        
        
    }
    
    static func createPost(forUID uid: String, question: String, tags: String, company: String, userID: String, completion: @escaping (Post?) -> Void) {
      
        let postAttrs = ["question": question, "tags": tags, "company": company, "userID": userID]
        
        let ref = Database.database().reference().child("UserPosts").child(uid).childByAutoId()
        let ref2 = Database.database().reference().child("GeneralPosts").childByAutoId()
        let refForCompanyQuestions = Database.database().reference().child("CompanyQuestions").child(company).childByAutoId() // saves as new node with company under companyquestions
        
        refForCompanyQuestions.updateChildValues(postAttrs) { (error, refForCompanyQuestions) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            refForCompanyQuestions.observeSingleEvent(of: .value, with: {(snapshot) in
                let post = Post(snapshot: snapshot)
                completion(post)
            })
        }
        
        ref2.updateChildValues(postAttrs) { (error, ref2) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                let post = Post(snapshot: snapshot)
                completion(post)
            })
        }
        
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
    } //^^ saves question, tags, and company as a post under the user

}
