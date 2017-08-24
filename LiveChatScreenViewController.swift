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
}
