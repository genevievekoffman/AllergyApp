//
//  AddPostViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
import Firebase

class AddPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var questiontextfield: UITextField!
    
    @IBOutlet weak var tagstextfield: UITextField!
    
    @IBOutlet weak var companypickerview: UIPickerView!
    
//    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var companySwitchView: UISwitch!
    
    @IBAction func companySwitch(_ sender: Any) {
        
        if companySwitchView.isOn {
            
            companypickerview.isHidden = false
        } else {
            companypickerview.isHidden = true
            
        }
    }
    

    var companies = [Vendor]() {
        didSet {
            companypickerview.reloadAllComponents()
        }
    }// array for every vendor in the app ** when vendor signs up, theyre name is added to the array

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companypickerview.delegate = self
        companypickerview.dataSource = self
        
        VendorService.allVendors(completion: { (vendors) in
            
            
            if let vendors = vendors {
                self.companies = vendors
            } else {
                print("Unable to obtain all vendors.")
            }

        
        })
        
//        companies = VendorService.arrayOfCompanies
    }
    
    func numberOfComponents(in companypickerview: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companies.count
    }
    var pickVar: String?
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickVar = companies[row].companyName
        return companies[row].companyName // ?
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        company = companies[row].companyName
    } // ^^ allows user to use UIPicker to choose a company
    
    @IBAction func AskButtonTapped(_ sender: Any) {
        if self.questiontextfield.text ==  "" || self.tagstextfield.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter a question and atleast 1 tag", preferredStyle: .alert) //creating pop up box if either tabs are empty
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil) // create constant, the "ok" on the box
            alertController.addAction(defaultAction) // put the action "ok" on the popup box
            self.present(alertController, animated: true, completion: nil) // presents the box
            // ^if email or password wasnt entered
            
        } else if companySwitchView.isOn == true { // if its on
            
            PostService.createPost(forUID: User.current.uid , question: questiontextfield.text!, tags: tagstextfield.text!, company: pickVar!, userID: User.current.uid) { (post) in
                
        }
            performSegue(withIdentifier: "segueToPostAdded", sender: self)
        }
            
        else if companySwitchView.isOn == false { // if its off- does a regular post to feed
            print("Posted")
            PostService.createPost(forUID: User.current.uid , question: questiontextfield.text!, tags: tagstextfield.text!, company: pickVar!, userID: User.current.uid) { (post) in
                
            }
            performSegue(withIdentifier: "segueToPostAdded", sender: self)
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.questiontextfield.resignFirstResponder()
        self.tagstextfield.resignFirstResponder()
    } // allows user to get out of keyboard
    
}
