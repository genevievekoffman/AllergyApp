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
    
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 6 //?
    }
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            let name = nameTextField.text,
            !username.isEmpty else {return} // checks if FirUser is logged in + username is provided
        
        UserService.create(firUser, username: username, name: name ) {(user) in
            guard let user = user else {
                return
            }
            guard let email = self.emailTextField.text, let password = self.passwordTextField.text else {return}
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
                if let error = error {
                    
                    self?.alert(message: error.localizedDescription)
                    return
                }
                Database.database().reference().child("Users").child(user!.uid).updateChildValues(["email":email, "username":username, "name":name])
                let changeRequest = user!.createProfileChangeRequest()
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: nil) // going to its location and updating its value (string)
            }
            User.setCurrent(user, writeToUserDefaults: true)
            
            let storyboard = UIStoryboard(name: "Main" , bundle: .main)
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } // Main storyboard opens
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
    } // click to get out of keyboard
}
