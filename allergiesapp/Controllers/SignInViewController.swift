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
    
//    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    @objc func keyboardNotification(notification: NSNotification) {
//        if let userInfo = notification.userInfo {
//            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
//            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
//            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
//            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
//            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
//            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
//                self.keyboardHeightLayoutConstraint?.constant = 0.0
//            } else {
//                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
//            }
//            UIView.animate(withDuration: duration,
//                           delay: TimeInterval(0),
//                           options: animationCurve,
//                           animations: { self.view.layoutIfNeeded() },
//                          completion: nil)
//        }
    // }  //^^moves the textfield when clicked on it so keyboard doesnt block it - doesnt work, it moves the muffin

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
//    func hideEmail () {
//        emailTextField.isSecureTextEntry = true // hides the email when user is typing
//    }
    
    @IBAction func LoginButton(_ sender: Any) {
        if self.emailTextField.text ==  "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and a a password", preferredStyle: .alert) //creating pop up box if either tabs are empty
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil) // create constant, the "ok" on the box
            alertController.addAction(defaultAction) // put the action "ok" on the popup box
            self.present(alertController, animated: true, completion: nil) // presents the box
            // ^if email or password wasnt entered
        } else {
            AuthService.signIn(controller: self, email: emailTextField.text!, password: passwordTextField.text!) { (user) in
                guard user != nil else { // performs auth service func, if user doesnt exist
                    print("error: FiRuser does not exist")
                    return
                }
                print("user is signed in") //if there is an existing user
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    } // click to get out of keyboard
    
    @IBOutlet weak var containerview2: UIView!
    @IBOutlet weak var containerview1: UIView!
    @IBOutlet weak var containerview3: UIView!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch segmentedController.selectedSegmentIndex
        {
        case 0:
            containerview1.isHidden = false
            containerview2.isHidden = true
            containerview3.isHidden = true
        case 1: // PROBLEM: when opened, container A should show
            containerview1.isHidden = true
            containerview2.isHidden = false
            containerview3.isHidden = true
        case 2:
            containerview3.isHidden = false
            containerview1.isHidden = true
            containerview2.isHidden = true
        default:
            break;
        }
   }
}
