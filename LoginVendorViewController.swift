//
//  LoginVendorViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/18/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class LoginVendorViewController: UIViewController {
    
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    
//    
//    @IBAction func LoginButtonTapped(_ sender: Any) {
//        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
//            let alertController = UIAlertController(title: "Error", message: "Please enter an email and a password", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            self.present(alertController, animated: true, completion: nil) // presents the box
//        } else {
//            AuthService.signIn(controller: self, email: emailTextField.text!, password: passwordTextField.text!) { (vendor) in
//                guard vendor != nil else {
//                    print("error: FiRuser does not exist")
//                    return
//                }
//                print("vendor is signed in")
//                VendorService.show(forUID: (vendor?.uid)!) { (vendor) in
//                    if let vendor = vendor {
//                        Vendor.setCurrent(vendor, writeToVendorDefaults: true)
//                        self.finishLoggingIn()
//                        print("vendor defaults set")
//                    } else {
//                        print("error: Vendor does not exist!")
//                        return
//                    }
//                }
//            }
//        }
//    }
//    func finishLoggingIn() {
//        let storyboard = UIStoryboard(name: "Vendor", bundle: .main) //???
//        if let initialViewController = storyboard.instantiateInitialViewController() {
//            self.view.window?.rootViewController = initialViewController
//            self.view.window?.makeKeyAndVisible()
//            // goes to the storyboard for vendors
//            
//        }
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.passwordTextField.resignFirstResponder()
//        self.emailTextField.resignFirstResponder()
//    }
}
