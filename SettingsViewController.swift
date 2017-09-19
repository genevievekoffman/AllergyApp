//
//  SettingsViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/20/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import SCLAlertView
import FirebaseAuth

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = User.current.name
        usernameLabel.text = User.current.username
        emailLabel.text = User.current.email
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSettingsToProfile", sender: self)
    }
    @IBAction func LogoutTapped(_ sender: Any) {
        // presentLogOut(viewController: self)
        AuthService.presentLogOut(viewController: self)
    }
    
  
    
//    func logUserOut() {
//        do {
//            try Auth.auth().signOut()
//            performSegue(withIdentifier: "backToLogin" , sender: self)
//        }
//        catch let error as NSError {
//    assertionFailure("Error: error signing in \(error.localizedDescription)")
//        }
//    }
    
//    func presentLogOut(viewController: UIViewController) {
//        let logOutAlert = UIAlertController(title: "Logout", message: nil, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Log out", style: .default, handler: { _ in
//            self.logUserOut()
//        })
//        
//        let cancelAction2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        logOutAlert.addAction(cancelAction)
//        logOutAlert.addAction(cancelAction2)
//        
//        self.present(logOutAlert, animated: true, completion: nil)
//    }

    
}






