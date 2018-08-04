//
//  UIColor+Theme.swift
//  Farfetch Challenge
//
//  Created by Wallace Souza Silva on 04/08/18.
//  Copyright © 2018 WallaCorp. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var twitchPurple: UIColor {
        return colorFromRGB(0x473978)
    }
    
    static var backgroundColor: UIColor {
        return colorFromRGB(0x1D1D1F)
    }
    
    private static func colorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
