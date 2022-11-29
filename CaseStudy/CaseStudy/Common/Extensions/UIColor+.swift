//
//  UIColor+.swift
//  CaseStudy
//
//  Created by Ömer Demir on 26.11.2022.
//

import UIKit

extension UIColor {
    
    @nonobjc class var xGray: UIColor {
        return UIColor(named: "xGray") ??  UIColor(red: 166.0 / 255.0, green: 166.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var xGreen: UIColor {
        return UIColor(named: "xGreen") ??  UIColor(red: 132.0 / 255.0, green: 221.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var xRed: UIColor {
        return UIColor(named: "xRed") ??  UIColor(red: 218.0 / 255.0, green: 97.0 / 255.0, blue: 93.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var xBlue: UIColor {
        return UIColor(named: "xBlue") ??  UIColor(red: 88.0 / 255.0, green: 131.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var xDarkGray: UIColor {
        return UIColor(named: "xDarkGray") ??  UIColor(red: 95.0 / 255.0, green: 95.0 / 255.0, blue: 95.0 / 255.0, alpha: 1.0)
    }
    
}
