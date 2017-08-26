//
//  VendorChatListVC.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/24/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class VendorChatListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func backButtontapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindsegue", sender: self)
    }
     @IBAction func unwindToVendorList(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var listOfChats = [Chat]() { // list of live chats
        didSet {
            tableView.reloadData()
        }
    }
    
    var vendorSendingName = Vendor.current.username
    var selectedChat : Chat?
    
    
    private lazy var chatRef : DatabaseReference =  Database.database().reference().child("chats")
    
    private var chatRefHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.title = "Chat List"
        
        usernameLabel.text = "welcome \(Vendor.current.companyName)"
        
    }
    
    deinit {
        if chatRefHandle != nil {
            chatRef.removeObserver(withHandle: chatRefHandle!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.listOfChats.removeAll() // ?? 
        observeChat()
        UIApplication.shared.isStatusBarHidden = true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vendorChatListCell") as! VendorChatListTableViewCell 
        let chatTitle = self.listOfChats[indexPath.row].chatTitle
        cell.chatTitleLabel.text = chatTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedChat = self.listOfChats[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "segueToVendorLiveChatVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToVendorLiveChatVC" {
            let vc = segue.destination as! VendorLiveChatVC
            vc.chat = selectedChat
            vc.chatRef = chatRef
            
            self.selectedChat = nil
        }

    }
    
    func observeChat() {
        chatRefHandle = chatRef.observe(.childAdded, with: { (snapshot) -> Void in
            let chatData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let chatName = chatData["chatName"] as! String!, chatName.characters.count > 0 {
                self.listOfChats.append(Chat(chatID: id, chatTitle: chatName))
            } else {
                print("Error")
            }
        })
    }
}
    




