//
//  LiveChatScreenViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/24/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController


final class LiveChatScreenViewController: JSQMessagesViewController {
    

    
    static var chatRef: DatabaseReference?
    var chat: Chat? {
        
        didSet {
            title = chat?.chatTitle
        }
    }
    
    var currentChat : Chat?
    
    
    var messages = [JSQMessage]()
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    private lazy var messageRef: DatabaseReference = LiveChatScreenViewController.chatRef!.child("messages")
    private var newMessageRefHandle: DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = User.current.uid
        self.senderDisplayName = User.current.username
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        observeMessages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func addMessage(withId id: String, name: String, text: String ) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef.childByAutoId()
        let messageItem = [
            "senderId": senderId!,
            "senderName": senderDisplayName!,
            "text": text!,
        ]
        itemRef.setValue(messageItem)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        finishSendingMessage()
    }
    
    
    
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    
    private func observeMessages() {
        messageRef = LiveChatScreenViewController.chatRef!.child("messages")
        
        let messageQuery = messageRef.queryLimited(toLast:25)
    
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
        
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                self.addMessage(withId: id, name: name, text: text)
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
        })
    }
}
