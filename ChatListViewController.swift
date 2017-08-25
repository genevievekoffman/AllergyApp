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

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var listOfChats = [Chat]() { // list of live chats
        didSet {
            tableView.reloadData()
        }
    }
    
    var userSendingName = User.current.username
    var selectedChat : Chat?
    
    private lazy var chatRef : DatabaseReference =  Database.database().reference().child("chats")
    
    private var chatRefHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        usernameLabel.text = "welcome \(User.current.name)"
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
        
        self.listOfChats.removeAll()
        observeChat() //??
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedChat = self.listOfChats[(indexPath as NSIndexPath).row]

//        let chat = self.listOfChats[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "SegueToLiveChatVC", sender: self)
        // Course.setCurrent(courseChat, writeToUserDefaults:true)
        // revealViewController().pushFrontViewController(revealViewController().frontViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToLiveChatVC" {
            let vc = segue.destination as! LiveChatScreenViewController
            vc.chat = selectedChat!
            LiveChatScreenViewController.chatRef = chatRef
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
    
//    @IBAction func unwindToChatListVC(_ sender: UIStoryboardSegue) {
//    self.tableView.reloadData()
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        if let chat = sender as? Chat {
//            let chatVC = segue.destination as! LiveChatScreenViewController
//            //chatVc.senderDisplayName = senderDisplayName
//           // chatVc.channel = channel
//          //  chatVc.channelRef = channelRef.child(channel.id)
//        }
//    }
    

}
    

