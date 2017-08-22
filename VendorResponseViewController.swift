//
//  VendorResponseViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/22/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class VendorResponseViewController: UIViewController {

    @IBOutlet weak var questionTextField: UILabel!
    @IBOutlet weak var tagsTextField: UILabel!
    
    
    var post: Post?
    
    override func viewDidLoad() {
        print(post!.question)
        
        questionTextField.text = post?.question
        tagsTextField.text = post?.tags
        
    }
    
} 
