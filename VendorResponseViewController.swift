//
//  VendorResponseViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/22/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class VendorResponseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func backbutton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToNotifications", sender: self)
    }
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var vendortableview: UITableView!
    
    
    var arrayOfResponses = [Response]() {
        didSet {
            vendortableview.reloadData()
        }
    }
    
    var post: Post?
    
    func loadResponses() {
        
        ResponseService.recieveAllResponse(forUID: Vendor.current.vendoruid, postID: post!.postID, completion: { (response) in
            if let legitResponse = response {
                self.arrayOfResponses = legitResponse
            } else {
                print("error")
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadResponses()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfResponses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "responsecell", for: indexPath) as! VendorResponseTableViewCell
        
        cell.ResponseTextLabel.text = arrayOfResponses[indexPath.row].response
        cell.Cellresponse = arrayOfResponses[indexPath.row]
        cell.CellUsernameLabel.text = arrayOfResponses[indexPath.row].usernameID
        
        return cell
    }
    
    override func viewDidLoad() {
        
        questionLabel.text = post?.question
        tagsLabel.text = post?.tags
        usernameLabel.text = post?.userID
        
    }
    
    @IBOutlet weak var AddResponseTextLabel: UITextField!
    
    @IBAction func commentResponse(_ sender: Any) {
        ResponseService.saveVendorResponse(forUID: Vendor.current.vendoruid, response: AddResponseTextLabel.text!, vendorID: Vendor.current.username, postID: post!.postID) {
            (response) in }
        AddResponseTextLabel.text = ""
        
        DispatchQueue.main.async {
            self.loadResponses()
        }
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.AddResponseTextLabel.resignFirstResponder()
    }
} // when responding, the cell should go to the end. Also, vendors comments should always be at the top
    

