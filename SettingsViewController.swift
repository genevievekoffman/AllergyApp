//
//  SettingsViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/20/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import Foundation

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
        AuthService.presentLogOut(viewController: self)

//        let loginstoryboard = UIStoryboard(name: "Login", bundle: .main)
//        let controller = UIStoryboard.initialViewController(for: .login)
//        self.present(controller, animated: false, completion: nil)

        
    } // ?? 
}





