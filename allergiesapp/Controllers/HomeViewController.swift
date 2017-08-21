 //
 //  HomeViewController.swift
 //  allergiesapp
 //
 //  Created by Genevieve Koffman on 8/7/17.
 //  Copyright © 2017 Genevieve Koffman. All rights reserved.
 //
 
 import UIKit
 
 
 class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
    var arrayOfPosts = [Post]() {
        didSet {
            tableView.reloadData()
        } // constantly sees any change in array
    }
    
    @IBOutlet weak var tableView: UITableView!
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PostService.retrieveAllPosts(forUID: User.current.uid , completion: { (posts) in
            if let legitposts = posts  {
                self.arrayOfPosts = legitposts
            } else {
                print("error")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toResponse") {
            let index = self.tableView.indexPathForSelectedRow!
            let thePost = arrayOfPosts[index.row]
            let responseVC = segue.destination as? ResponsesViewController
            responseVC?.post = thePost
        }
    } // ^^??
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPosts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as! PostTableViewCell
        
        cell.questiontextLabel.text = arrayOfPosts[indexPath.row].question
        cell.tagstextLabel.text = arrayOfPosts[indexPath.row].tags
        
        UserService.show(forUID: arrayOfPosts[indexPath.row].userID, completion: {(user) in
            cell.usernameLabel.text = user?.username
            
        })
        
        
        
        cell.cellPost = arrayOfPosts[indexPath.row]
        
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 }
 
 
 
 
