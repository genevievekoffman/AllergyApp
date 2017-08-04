//
//  LoginViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/2/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LoginButton(_ sender: Any) {
        if self.emailTextField.text ==  "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and a a password", preferredStyle: .alert) //creating pop up box if either are empty
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil) // the action on the box ("ok")
            alertController.addAction(defaultAction) // put the action "ok" on the box
            self.present(alertController, animated: true, completion: nil) // present the box
            
        } else {
            AuthService.signIn(controller: self, email: emailTextField.text!, password: passwordTextField.text!) { (user) in
                guard user != nil else { // performs auth service func and then print
                    print("error: FiRuser does not exist")
                    return
                }
                print("user is signed in")
                UserService.show(forUID: (user?.uid)!) { (user) in
                    if let user = user {
                        User.setCurrent(user, writeToUserDefaults: true)
                        self.finishLoggingIn()
                        print("user defaults set")
                    } else {
                        print("error: User does not exist!")
                        return
                    } // gets user from database
                }
            }
        }
    }
    func finishLoggingIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            // goes to the main storyboard
            
        }
    }
    
    @IBOutlet weak var containerview2: UIView!
    @IBOutlet weak var containerview1: UIView!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedController.selectedSegmentIndex
        {
        case 0:
            containerview1.isHidden = false
            containerview2.isHidden = true
        case 1:
            containerview1.isHidden = true
            containerview2.isHidden = false
        default:
            break;
        }
   }
}
