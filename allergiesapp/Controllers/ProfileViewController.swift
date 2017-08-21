//
//  ProfileViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
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

}
