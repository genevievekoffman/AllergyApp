//
//  PostAdded.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class PostAdded: UIViewController  {
    
    @IBAction func ReturnToHomeScreenButton(_ sender: Any) {
        performSegue(withIdentifier: "segueToHomeScreen" , sender: self)
        // returns to home screen --- add delete post button later
    }
}
