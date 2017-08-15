//
//  HomeViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    var arrayOfPosts = [Post]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        cell.cellPost = arrayOfPosts[indexPath.row]  
        print("\(arrayOfPosts)")
        return cell
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//    var post: [Post]?
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if let post = post {
//            questionLabel.text = post.question
//            TagsLabel.text = post.tags
//        } else {
//            questionLabel.text = ""
//            TagsLabel.text = ""
//        }
//    }


