//
//  ResponsesViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/15/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class ResponsesViewController: UIViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        print(post!.question)
        
        TagsQuestionLabel.text = post?.tags
        QuestiontextLabel.text = post?.question
    }
    
    @IBOutlet weak var TagsQuestionLabel: UILabel!
    @IBOutlet weak var QuestiontextLabel: UILabel!
}
