//
//  NotificationsQuestionsViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/20/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class NotificationsQuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfCompanyPosts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PostService.retrieveCompaniesPosts(forUID: Vendor.current.vendoruid, completion: {(posts) in
            if let legitCompanyPost = posts {
                self.arrayOfCompanyPosts = legitCompanyPost
            } else {
            print("error")
            }
        })
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "segueToNotifications") {
//        let index = self.tableView.indexPathForSelectedRow!
//        let theCompanyQuestion = arrayOfCompanyPosts[index.row]
//        let notificationVC = segue.destination as?
//            // storyboard
//            notificationVC?.post = theCompanyQuestion
//    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCompanyPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCompanies", for: indexPath) as! PostCompaniesTableViewCell
        
        cell.questiontextLabel.text = arrayOfCompanyPosts[indexPath.row].question
        cell.tagstextLabel.text = arrayOfCompanyPosts[indexPath.row].tags
        cell.companyLabel.text = arrayOfCompanyPosts[indexPath.row].company
        cell.usernameLabel.text = arrayOfCompanyPosts[indexPath.row].userID

        cell.cellCompaniesPost = arrayOfCompanyPosts[indexPath.row]
 
        return cell
        
    }
    
}
