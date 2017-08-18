//
//  FoodAllergiesViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/16/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit
// import Firebase

class FoodAllergiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var noDuplicates = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        AllergyService.recieveMyAllergies(userID: User.current.uid, completion: { (arrayOfAllergies) in
        
        guard let arrayOfAllergies = arrayOfAllergies else {
            return
        }
        
        self.noDuplicates = Array(Set(arrayOfAllergies))

        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(self.noDuplicates.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allergyCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "allergyCell")
        
        allergyCell.textLabel?.text = self.noDuplicates[indexPath.row]
        return (allergyCell)
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindSeguetoProfile" , sender: self)
    }
    
    @IBAction func unwindToFoodAllergiesViewController(segue: UIStoryboardSegue) {} //
}
