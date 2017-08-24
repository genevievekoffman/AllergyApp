//
//  ChatListViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/24/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseDatabase


class ChatListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var chatArray = [Chat]()

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var listOfChats = [Chat]() { // list of live chats
        didSet {
            tableView.reloadData()
        }
    }
    
    var userSendingName = User.current.username
    
    private lazy var chatRef : DatabaseReference =  Database.database().reference().child("chats")
    
    private var chatRefHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "welcome \(User.current.name)"
    }
    
    deinit {
        if let refHandle = chatRefHandle {
            chatRef.removeObserver(withHandle: chatRefHandle!)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listOfChats.removeAll()
        observeChat() //??
        self.tableView.reloadData()
        UIApplication.shared.isStatusBarHidden = true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listChatsCell") as! ChatListTableViewCell
        let chatTitle = self.listOfChats[indexPath.row].chatTitle
        cell.chatTitleLabel.text = chatTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let chat = self.listOfChats[(indexPath as NSIndexPath).row]
        // Course.setCurrent(courseChat, writeToUserDefaults:true)
        // revealViewController().pushFrontViewController(revealViewController().frontViewController, animated: true)
    }
    
    func observeChat() {
        chatRefHandle = chatRef.observe(.childAdded, with: { (snapshot) -> Void in
            let chatData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let chatName = chatData["chatName"] as! String!, chatName.characters.count > 0 {
                self.chatArray.append(Chat(chatID: id, chatTitle: chatName))
                self.tableView.reloadData()
            } else {
               print("Error")
            }
        })
    }
    
    @IBAction func unwindToChatListVC(_ sender: UIStoryboardSegue) {
    self.tableView.reloadData()
    }
    
    
}
