//
//  ColorTheme+ForeGround.swift
//  Joobjoob
//
//  Created by zehye on 12/26/25.
//

import UIKit

// MARK: ColorTheme + Foreground
extension ColorTheme {
    convenience init(foreground type: Foreground) {
        self.init(light: LightTheme.foreground(type), dark: DarkTheme.foreground(type))
    }
}

// MARK: ColorThemeable + Foreground
extension ColorThemeable {
    static func foreground(_ type: ColorTheme.Foreground) -> UIColor { return .clear }
}

// MARK: ColorTheme + Foreground
extension ColorTheme {
    enum Foreground {
        case clear
        case white
        
    }
}

// MARK: ColorTheme.LightTheme + Foreground
extension ColorTheme.LightTheme {
    static func foreground(_ type: ColorTheme.Foreground) -> UIColor {
        switch type {
        case .clear: return UIColor.clear
        case .white: return UIColor(hexString: "#FFFFFF")
        }
    }
}
