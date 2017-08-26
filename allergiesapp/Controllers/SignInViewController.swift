//
//  SigninViewController.swift
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
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
    }
    
    @IBOutlet weak var ConsumerOrVendor: UISegmentedControl!
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSignInToOpeningScreen", sender: self)
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    
    @IBAction func LoginButton(_ sender: Any) {
        if self.emailTextField.text ==  "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and a a password", preferredStyle: .alert) //creating pop up box if either tabs are empty
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil) // create constant, the "ok" on the box
            alertController.addAction(defaultAction) // put the action "ok" on the popup box
            self.present(alertController, animated: true, completion: nil) // presents the box
            // ^if email or password wasnt entered
            
        } else if ConsumerOrVendor.selectedSegmentIndex == 0 {
            guard let email = emailTextField.text,
                let password = passwordTextField.text
                else { return }
            AuthService.signIn(controller: self, email: email, password: password) { (user) in
                guard user != nil else { // performs auth service func, if user doesnt exist
                    print("error: FiRuser does not exist")
                    return
                }
                print("user is signed in") //if there is an existing user
                UserService.show(forUID: (user?.uid)!) { (user) in
                    if let user = user {
                        User.setCurrent(user, writeToUserDefaults: true)
                        self.finishUserLoggingIn()
                        print("user defaults set")
                    }
                }
            }
        }
        else if ConsumerOrVendor.selectedSegmentIndex == 1 {
            guard let email = emailTextField.text,
                let password = passwordTextField.text
                else { return }
            AuthService.signIn(controller: self, email: email, password: password) { (vendor) in
                guard vendor != nil else {
                    print("error: FiRuser does not exist")
                    return
                }
                print("vendor is signed in")
                VendorService.show(forUID: (vendor?.uid)!){ (vendor)  in
                    if let vendor = vendor {
                        Vendor.setCurrent(vendor, writeToVendorDefaults: true)
                        self.finishVendorLoggingIn()
                        print("vendor defaults set")
                    }
                } // error logging in vendors 
            }
        }else {
            print("error: User does not exist!")
            return
        } // gets user from database
        
    }
    
    func finishUserLoggingIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
            // goes to the main storyboard
            
        }
    }
    
    func finishVendorLoggingIn() {
        let storyboard = UIStoryboard(name: "Vendor", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    } // click to get out of keyboard
    
}
