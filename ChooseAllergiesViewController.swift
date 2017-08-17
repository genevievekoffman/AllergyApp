//
//  ChooseAllergiesViewController.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/16/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit



class ChooseAllergiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let allergyList = ["Peanuts", "Tree Nuts", "Milk", "Eggs", "Wheat", "Soy", "Fish", "ShellFish"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(allergyList.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //   let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allergyList[indexPath.row]
        
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        // selected allergies save to firebase 
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
       performSegue(withIdentifier: "segueToFoodAllergyViewController", sender: self)
    }
    
    
}
