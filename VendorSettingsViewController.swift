//
//  VendorSettingsViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/23/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//


import UIKit


class VendorSettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "VendorSettingsToOpeningVC", sender: self)
    }
    
    
    @IBAction func LogoutButtonTapped(_ sender: Any) {
        AuthService.presentLogOut(viewController: self)
        AppDelegate.clearUserDefaults()()
        
    } // ?? 
    
    
}
