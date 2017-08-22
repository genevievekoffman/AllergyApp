//
//  VendorOpeningViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/21/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit



class VendorOpeningViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameLabel.text? = Vendor.current.companyName
    }
    
    @IBAction func unwindSegueToVendorProfile(segue: UIStoryboardSegue) {}
    
}
