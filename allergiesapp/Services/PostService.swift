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
    
    static func retrieveCompaniesQuestions(forUID uid: String, completion: @escaping ([Post]?) -> Void) {
        let ref = Database.database().reference().child("CompanyQuestions").child(uid) //reaching into the questions asked of a company
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else {
                    return completion([]) }
            var arrayOfQuestionsaskedToCompany = [Post]()
            print (snapshot)
            for postSnap in snapshot {
                print(postSnap)
                guard let post = Post(snapshot: postSnap)
                    else { return completion([]) }
                arrayOfQuestionsaskedToCompany.append(post) }
            completion(arrayOfQuestionsaskedToCompany)
        }) // retrieving every question asked to the company/vendor
    }
    
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
                arrayOfAllPosts.append(post)
            }
            
            completion(arrayOfAllPosts)
        }) // retrieving every post on the app, returns an array of all posts
    }
    
    static func createPost(forUID uid: String, question: String, tags: String, company: String, userID: String, completion: @escaping (Post?) -> Void) {
        
        let postAttrs = ["question": question, "tags": tags, "company": company, "userID": userID]
        
        let ref = Database.database().reference().child("UserPosts").child(uid).childByAutoId()
        let ref2 = Database.database().reference().child("GeneralPosts").child(ref.key)
        let refForCompanyQuestions = Database.database().reference().child("CompanyQuestions").child(company).child(ref.key) // saves as new node with company under companyquestions
        
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
    
    static func flag(_ post: Post) {
        guard let postKey = post.postID else { return } // checks if its a post
        let flaggedPostRef = Database.database().reference().child("flaggedPosts").child(postKey)
        
        
        let flaggedDict = ["postID": post.postID,
                           "reporterID": User.current.uid]
        
        flaggedPostRef.updateChildValues(flaggedDict)
    
        let flagCountRef = flaggedPostRef.child("flag_count")
        flagCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
            let currentCount = mutableData.value as? Int ?? 0
            
            mutableData.value = currentCount + 1
            
            return TransactionResult.success(withValue: mutableData)
        })
    }
    
}
