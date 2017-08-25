//
//  ProfileViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBAction func LiveChatsButtonTapped(_ sender: Any) {
        goToLiveChatStoryboard()
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text? = User.current.username
    }
    
    @IBAction func ButtonToMyAllergies(_ sender: Any) {
        performSegue(withIdentifier: "segueToFoodAllergiesViewController", sender: self)
    }
     @IBAction func unwindToProfile(segue: UIStoryboardSegue) {}
    @IBAction func unwindSettingsToProfile(segue: UIStoryboardSegue) {}

    
    func goToLiveChatStoryboard() {
        let storyboard = UIStoryboard(name: "LiveChat", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    } // goes to live chat storyboard
}
