//
//  ResponsesViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/15/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit


class ResponsesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func BackButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    var arrayOfResponses = [Response]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var post: Post?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ResponseService.recieveAllResponse(forUID: User.current.uid, postID: post!.postID! , completion: { (response) in
            if let legitResponse = response {
            self.arrayOfResponses = legitResponse
            } else {
                print("error")
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfResponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responseTableViewCell", for: indexPath) as! ResponseTableViewCell
        
        cell.ResponseTextLabel.text = arrayOfResponses[indexPath.row].response
        
        cell.Cellresponse = arrayOfResponses[indexPath.row]
        
        cell.CellUsernameLabel.text = arrayOfResponses[indexPath.row].usernameID
        
        return cell 
    }


    override func viewDidLoad() {
        print(post!.question)
        
        TagsQuestionLabel.text = post?.tags
        QuestiontextLabel.text = post?.question // sets the matching question and tag
    }
    
    @IBOutlet weak var TagsQuestionLabel: UILabel!
    @IBOutlet weak var QuestiontextLabel: UILabel!


    @IBOutlet weak var AddCommentTextLabel: UITextField!
    
    @IBAction func CommentArrow(_ sender: Any) {
        ResponseService.saveResponse(forUID: User.current.uid , response: AddCommentTextLabel.text!, usernameID: User.current.username, postID: post!.postID!) {
            (response) in }
        AddCommentTextLabel.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.AddCommentTextLabel.resignFirstResponder()
    }
}
