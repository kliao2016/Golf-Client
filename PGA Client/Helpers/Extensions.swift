//
//  Extensions.swift
//  PGA Client
//
//  Created by Kevin Liao on 7/21/18.
//  Copyright © 2018 Kevin Liao. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct CustomColors {
        static let blue = UIColor.rgb(red: 89, green: 210, blue: 254)
        static let green = UIColor.rgb(red: 158, green: 228, blue: 147)
        static let red = UIColor.rgb(red: 239, green: 98, blue: 108)
        static let light = UIColor.rgb(red: 239, green: 248, blue: 255)
        static let lightBlue = UIColor.rgb(red: 209, green: 245, blue: 255)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    // Shortcut and modularized code for adding constraints
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDict = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}
