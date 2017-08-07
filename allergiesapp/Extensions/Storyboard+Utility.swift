//
//  Storyboard+Utility.swift
//  allergiesapp
//
//  Created by Genevieve Koffman on 8/7/17.
//  Copyright © 2017 Genevieve Koffman. All rights reserved.
//


import UIKit

extension UIStoryboard {
    enum MGType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        return initialViewController
    } //if there is a view controller(stroyboard) then show it as an initial view controller. if there is no storyboard --> returns error
} // ^^ info for keeping a user logged in
