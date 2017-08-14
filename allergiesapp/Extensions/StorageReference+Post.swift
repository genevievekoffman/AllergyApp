//
//  StorageReference+Post.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/8/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static func newPostQuestionReference() -> StorageReference {
        let uid = User.current.uid
        
        return Storage.storage().reference().child("questions/posts/\(uid)")
    }
}
 // creates extension to StorageReference with a class method that will generate a new location for each new post (question) 
