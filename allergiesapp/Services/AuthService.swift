//
//  AuthService.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/3/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseDatabase
import SCLAlertView


struct AuthService {
    
    // Signs in as an authenticated user on Firebase
    static func signIn(controller : UIViewController, email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                loginErrors(error: error, controller: controller)
                return completion(nil)
            }
            return completion(user)
        }
    }
    // Creates an authenticated user on Firebase
    static func createUser(controller : UIViewController, email: String, password: String, completion: @escaping (FIRUser?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                signUpErrors(error: error, controller: controller)
                return completion(nil)
            }
            
            return completion(Auth.auth().currentUser)
        }
    }
    // Allows you to reset password for an email
    static func passwordReset(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("email error for: \(email)")
                print("error: \(error.localizedDescription)")
                return
            }
        }
}
    
    static func presentPasswordReset(controller : UIViewController){
        let alertController = UIAlertController(title: "Are you sure you want to reset your password?", message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Send Email", style: .default) { _ in
            guard let auth = Auth.auth().currentUser,
                let email = auth.email else {
                    
                    print ("error")
                    // SCLAlertView().genericError()
                    return
            }
            AuthService.passwordReset(email: email, success: { (success) in
                if success {
                    SCLAlertView().showSuccess("Success!", subTitle: "Email sent.")
                }
                else {
                    print ("error")
                    // SCLAlertView().genericError()
                }
            })
        }
        
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if let popover = alertController.popoverPresentationController {
            popover.sourceView = controller.view;
            popover.sourceRect = CGRect(x: controller.view.bounds.midX, y: controller.view.bounds.midY, width: 0, height: 0)
        }
        
        controller.present(alertController, animated: true)
    }
    
    static func passwordReset(email: String, success : @escaping (Bool) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("email error for: \(email)")
                print("error: \(error.localizedDescription)")
                return success(false)
            }
            return success(true)
        }
    }
    
    static func removeAuthListener(authHandle : AuthStateDidChangeListenerHandle?){
        if let authHandle = authHandle {
            Auth.auth().removeStateDidChangeListener(authHandle)
        }
    }
    
    /*
     ====================== WARNING ==========================
     Only use this function where you create the AuthListener!
     It can cause problems otherwise since the listener might
     not be removed. You can also make sure that the listener
     is removed.
     =========================================================
     */
    static func presentLogOut(viewController : UIViewController){
        let alertController = UIAlertController(title: "Are You Sure You Want To Logout", message: nil, preferredStyle: .actionSheet)
        

        let signOutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            logUserOut()
            
        }
        
        alertController.addAction(signOutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if let popover = alertController.popoverPresentationController {
            popover.sourceView = viewController.view;
            popover.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
        }
        
        viewController.present(alertController, animated: true)
    }
    
    
    static func logUserOut(_ clearUser : Bool = true){
        do {
            try Auth.auth().signOut()
            if clearUser {
                User.clearCurrent()
            }
            
        } catch let error as NSError {
            assertionFailure("Error signing out: \(error.localizedDescription)")
        }
    }
    
    
    private static func loginErrors(error : Error, controller : UIViewController){
        switch (error.localizedDescription) {
        case "The email address is badly formatted.":
        let invalidEmailAlert = UIAlertController(title: "Invalid Email", message:
            "It seems like you have put in an invalid email.", preferredStyle: UIAlertControllerStyle.alert)
        invalidEmailAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        controller.present(invalidEmailAlert, animated: true, completion: nil)
        break;
        case "The password is invalid or the user does not have a password.":
        let wrongPasswordAlert = UIAlertController(title: "Wrong Password", message:
            "It seems like you have entered the wrong password.", preferredStyle: UIAlertControllerStyle.alert)
        wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        controller.present(wrongPasswordAlert, animated: true, completion: nil)
        break;
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
        let wrongPasswordAlert = UIAlertController(title: "No Account Found", message:
            "We couldn’t find an account that corresponds to that email. Do you want to create an account?", preferredStyle: UIAlertControllerStyle.alert)
        wrongPasswordAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        controller.present(wrongPasswordAlert, animated: true, completion: nil)
        break;
        default:
            let loginFailedAlert = UIAlertController(title: "Error Logging In", message:
                "There was an error logging you in. Please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
            loginFailedAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(loginFailedAlert, animated: true, completion: nil)
            break; // happens with small errors ex: short passcode
        }
}
    private static func signUpErrors(error: Error, controller: UIViewController) {
        switch(error.localizedDescription) {
        case "The email address is badly formatted.":
        let invalidEmail = UIAlertController(title: "Email is not properly formatted.", message:
            "Please enter a valid email to sign up with..", preferredStyle: UIAlertControllerStyle.alert)
        invalidEmail.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        controller.present(invalidEmail, animated: true, completion: nil)
        break;
        default:
            let generalErrorAlert = UIAlertController(title: "We are having trouble signing you up.", message:
                "Please try again soon.", preferredStyle: UIAlertControllerStyle.alert)
            generalErrorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
            controller.present(generalErrorAlert, animated: true, completion: nil)
            break;
        }
    }
    
}
