 //
//  HomeViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as! PostTableViewCell
        
        cell.questiontextLabel.text = arrayOfPosts[indexPath.row].question
        cell.tagstextLabel.text = arrayOfPosts[indexPath.row].tags
//        cell.usernameLabel.text = // username of poster
        
        cell.cellPost = arrayOfPosts[indexPath.row]
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




