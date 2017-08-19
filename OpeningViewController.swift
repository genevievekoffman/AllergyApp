//
//  OpeningViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/18/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit


class OpeningViewController: UIViewController {
    
    @IBAction func SignInButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "segueToSignInViewController", sender: self)
    }
    
    @IBAction func SignUpButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "segueToSignUpViewController", sender: self)
    }
    
    @IBAction func unwindToOpeningScreen(segue: UIStoryboardSegue) {} // 
    
}
