//
//  PostCompaniesTableViewCell.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/20/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class PostCompaniesTableViewCell: UITableViewCell {
    var cellCompaniesPost : Post?
    
    @IBOutlet weak var questiontextLabel: UILabel!
    @IBOutlet weak var tagstextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
