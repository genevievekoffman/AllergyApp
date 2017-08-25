//
//  VendorOpeningViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/21/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseDatabase


class VendorOpeningViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameLabel.text? = Vendor.current.companyName
    }
    
    @IBAction func unwindSegueToVendorProfile(segue: UIStoryboardSegue) {}
    

    @IBAction func SettingsButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "SegueToSettings", sender: self)
    }
    
    func createLiveChat(chatName: String?) {
        let newChatRef =  Database.database().reference().child("chats").childByAutoId()
        let chatItem = ["chatName": chatName ]
        newChatRef.setValue(chatItem)
    }
    
    func performSegue(identifier: String) {
        self.performSegue(withIdentifier: identifier, sender: self )
    }
    
    @IBAction func HostLiveChatButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Live Chat", message: "Enter a new Chat name:", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "ex: The 5 natural ingredients in our cake"
        }
        self.present(alert, animated: true, completion: nil) // correct placement? 
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            if let textFieldText = alert?.textFields?[0].text {
                self.createLiveChat(chatName: textFieldText)
                self.performSegue(identifier: "segueToHostLiveChat")
                }
            })
        )}
    // segue to storyboard 
    }
