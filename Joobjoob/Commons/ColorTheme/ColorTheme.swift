//
//  ColorTheme.swift
//  Joobjoob
//
//  Created by zehye on 12/26/25.
//

import UIKit

extension UIColor {
    convenience init(light: CGFloat, dark: CGFloat) {
        self.init(light: UIColor(white: light, alpha: 1), dark: UIColor(white: dark, alpha: 1))
    }

    convenience init(light: CGFloat, dark: UIColor) {
        self.init(light: UIColor(white: light, alpha: 1), dark: dark)
    }

    convenience init(light: UIColor, dark: CGFloat) {
        self.init(light: light, dark: UIColor(white: dark, alpha: 1))
    }

    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, *) {
            self.init(dynamicProvider: { (collection) -> UIColor in
                return collection.userInterfaceStyle == .light ? light : dark
            })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
}

// MARK: ColorTheme
class ColorTheme: UIColor {
}

// MARK: ColorThemeable
protocol ColorThemeable { }

// MARK: ColorTheme + LightTheme
extension ColorTheme {
    struct LightTheme: ColorThemeable { }
}

// MARK: ColorTheme + DarkTheme
extension ColorTheme {
    struct DarkTheme: ColorThemeable { }
}
