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
    
    var myAllergiesList = [String]() // USE FOR RETRIEVAL
    
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
            if let index = myAllergiesList.index(of: (tableView.cellForRow(at: indexPath)?.textLabel?.text)!) {
                myAllergiesList.remove(at: index) // delete from array
            }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
             myAllergiesList.append((tableView.cellForRow(at: indexPath)?.textLabel?.text)!) // add the string to array
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    

    

    @IBAction func addButtonTapped(_ sender: Any) {
        for allergy in myAllergiesList {
            AllergyService.saveMyAllergies(allergy: allergy, userID: User.current.uid, completion: {_ in})
        }
        performSegue(withIdentifier: "unwindsegueToFoodAllergies", sender: self)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
       performSegue(withIdentifier: "unwindsegueToFoodAllergies", sender: self)
    }
    
}
