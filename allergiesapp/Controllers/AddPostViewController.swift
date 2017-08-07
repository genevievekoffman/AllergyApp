//
//  AddPostViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit


class AddPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var questiontextfield: UITextField!
    
    @IBOutlet weak var tagstextfield: UITextField!
    
    @IBOutlet weak var companypickerview: UIPickerView!
    
    @IBOutlet weak var label: UILabel!
    
    var companies = ["No Company", "bai", "pearl river"] // later I will have to add to this array for every vendor in the app **
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companypickerview.delegate = self
        companypickerview.dataSource = self
    }
    
    func numberOfComponents(in companypickerview: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companies.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return companies[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = companies[row]
    } // ^^ allows user to use UIPicker to choose a company
    
    @IBAction func AskButtonTapped(_ sender: Any) {
        if self.questiontextfield.text ==  "" || self.tagstextfield.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter a question and atleast 1 tag", preferredStyle: .alert) //creating pop up box if either tabs are empty
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil) // create constant, the "ok" on the box
            alertController.addAction(defaultAction) // put the action "ok" on the popup box
            self.present(alertController, animated: true, completion: nil) // presents the box
            // ^if email or password wasnt entered
        } else {
            print("Posted")
            performSegue(withIdentifier: "segueToPostAdded", sender: self) // if all info is there, goes to posted view controller
            
        }
        let question =  questiontextfield.text
        let tags = tagstextfield.text
        let company = label.text
        
        print ("\(String(describing: question)), \(String(describing: tags)), \(String(describing: company))") // just printing their post 
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.questiontextfield.resignFirstResponder()
        self.tagstextfield.resignFirstResponder()
    } // allows user to get out of keyboard
}
