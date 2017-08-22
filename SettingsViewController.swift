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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSettingsToProfile", sender: self)
    }
    @IBAction func LogoutTapped(_ sender: Any) {
       AuthService.presentLogOut(viewController: self)
        AppDelegate.clearUserDefaults()
        

    } // ?? 
}





