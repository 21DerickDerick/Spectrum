//
//  UIColor+Additions.swift
//  Spectrum
//
//  Created by Derick on 5/6/20.
//  Copyright © 2020 DerickDev. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var spectrumMain : UIColor {
        return hexStringToUIColor(hex: "#2A404C")
    }

    @nonobjc class var spectrumSecondary : UIColor {
        return hexStringToUIColor(hex: "#4B5F69")
    }
    
    @nonobjc class var spectrumBackground : UIColor {
        return hexStringToUIColor(hex: "#F2F7FA")
    }
    
    @nonobjc class var spectrumFollowButton : UIColor {
        return hexStringToUIColor(hex: "#5D80A6")
    }
    
    private static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
