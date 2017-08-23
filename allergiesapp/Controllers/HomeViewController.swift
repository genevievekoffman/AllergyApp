 //
 //  HomeViewController.swift
 //  allergiesapp
 //
 //  Created by Genevieve Koffman on 8/7/17.
 //  Copyright © 2017 Genevieve Koffman. All rights reserved.
 //
 
 import UIKit
 
 
 class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
    
    var arrayOfPosts = [Post]() {
        didSet {
            tableView.reloadData()
        } // constantly sees any change in array
    }
    
    var isSearching = false //
    
    var filteredPosts = [Post]() {
        didSet {
            tableView.reloadData()
        }
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
        //searchBar.delegate = self //
        //searchBar.returnKeyType = UIReturnKeyType.done //
        
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
        
        if isSearching { //
            return filteredPosts.count
        } else {
            return arrayOfPosts.count
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell", for: indexPath) as! PostTableViewCell
        
        if isSearching { //when you are searching case
            cell.questiontextLabel.text = filteredPosts[indexPath.row].question
            cell.tagstextLabel.text = filteredPosts[indexPath.row].tags
            UserService.show(forUID: filteredPosts[indexPath.row].userID, completion: {(user) in
                cell.usernameLabel.text = user?.username
            })
            cell.cellPost = filteredPosts[indexPath.row]
            
            
            
        } else { //when you are not searching case
            
            cell.questiontextLabel.text = arrayOfPosts[indexPath.row].question
            cell.tagstextLabel.text = arrayOfPosts[indexPath.row].tags
            UserService.show(forUID: arrayOfPosts[indexPath.row].userID, completion: {(user) in
                cell.usernameLabel.text = user?.username
            })
            cell.cellPost = arrayOfPosts[indexPath.row]
            
            
        }
    
        
        return cell
    }
    
    override func viewDidLoad() {
        searchBar.delegate = self
        super.viewDidLoad()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsScopeBar = true
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            
            view.endEditing(true)
            
            tableView.reloadData()
        } else {
            
            isSearching = true
            filteredPosts = arrayOfPosts.filter({$0.tags.contains(searchText.lowercased()) || $0.question.contains(searchText.lowercased())})
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = false //
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 }
 
 
 
 
