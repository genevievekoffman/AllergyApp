//
//  VendorSettingsViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/23/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//


import UIKit
import FirebaseAuth
import SCLAlertView


class VendorSettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameLabel.text = Vendor.current.companyName
        usernameLabel.text = Vendor.current.username
        emailLabel.text = Vendor.current.email
    }
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "VendorSettingsToOpeningVC", sender: self)
    }
    @IBAction func ChangePasswordButton(_ sender: Any) {
        AuthService.presentPasswordReset(controller: self ) ///
    }
    
    
    
    
    @IBAction func LogoutButtonTapped(_ sender: Any) {
        AuthService.presentLogOut(viewController: self)
        AppDelegate.clearUserDefaults()
        
        let loginstoryboard = UIStoryboard(name: "Login", bundle: .main)
        if let initialViewController = storyboard?.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
}
