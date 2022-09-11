//
//  UIFont+Constants.swift
//  VIPER-Demo
//
//  Created by Martin Regas on 10/09/2022.
//

import UIKit

enum FontName: String {
    case primary = "get schwifty"
    case secondary = "DINPro-Regular"
    case secondaryBold = "DINPro-Bold"
}

extension UIFont {
    static func font(name: FontName, size: CGFloat) -> UIFont {
        let font = UIFont(name: name.rawValue, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
}
