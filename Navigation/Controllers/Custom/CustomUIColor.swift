//
//  CustomUIColor.swift
//  Navigation
//
//  Created by new owner on 17.02.2023.
//

import UIKit

extension UIColor {

    convenience init(hex: String) {
        var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        if hexFormatted.count != 6 {
            self.init(white: 0.5, alpha: 1.0)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}

let myColor = UIColor(hex: "#4855CC")
