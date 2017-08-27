//
//  PostTableViewCell.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/15/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var cellPost : Post?
    
    @IBOutlet weak var questiontextLabel: UILabel!
    @IBOutlet weak var tagstextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBAction func flagButton(_ sender: UIButton) {
        if let closure = didTapOptionsButtonForCell {
            closure(self)
        }
    }
    
     var didTapOptionsButtonForCell: ((PostTableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
