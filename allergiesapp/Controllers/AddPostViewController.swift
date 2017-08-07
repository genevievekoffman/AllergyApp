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
    
    var companies = ["bai", "pearl river"]
    
    
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
    }
    
}
