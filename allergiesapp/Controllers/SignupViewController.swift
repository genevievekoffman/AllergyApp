//
//  SignupViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/3/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

// class for signing up userservice.swift

import UIKit
import FirebaseAuth
import FirebaseDatabase


class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nextButton.layer.cornerRadius = 6 //?
    }
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var consumerORvendor: UISegmentedControl!
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSignUpToOpeningScreen", sender: self)
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if consumerORvendor.selectedSegmentIndex == 0 {
            guard let username = usernameTextField.text,
                let name = nameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text
                else { return }
            
            AuthService.createUser(controller: self, email: email, password: password) { (authUser) in
                guard let firUser = authUser else {
                    return
                }
                
                UserService.create(firUser, username: username, name: name, email: email) { (user) in
                    guard let user = user else {
                        return
                    }
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    
                    let storyboard = UIStoryboard(name: "Main" , bundle: .main)
                    if let initialViewController = storyboard.instantiateInitialViewController() {
                        self.view.window?.rootViewController = initialViewController
                        self.view.window?.makeKeyAndVisible()
                    } // Main storyboard opens
                }
            }
        }
        
       else if consumerORvendor.selectedSegmentIndex == 1 { //vendor/company signed up
            guard let username = usernameTextField.text,
                let name = nameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text
                else { return }
            
            AuthService.createUser(controller: self, email: email, password: password) { (authUser) in
                guard let firUser = authUser else {
                    return
                }
                
                VendorService.create(firUser, username: username, companyName: name, email: email) { (vendor) in
                    guard let vendor = vendor else {
                        return
                    }
                    Vendor.setCurrent(vendor, writeToVendorDefaults: true)
                    
                    let storyboard = UIStoryboard(name: "Vendor", bundle: .main)
                    if let initialViewController = storyboard.instantiateInitialViewController() {
                        self.view.window?.rootViewController = initialViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
    } // click to get out of keyboard
}
