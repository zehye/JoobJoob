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
        case black
        case kakalYellow
        case naverGreen
        case grey
    }
}

// MARK: ColorTheme.LightTheme + Foreground
extension ColorTheme.LightTheme {
    static func foreground(_ type: ColorTheme.Foreground) -> UIColor {
        switch type {
        case .clear: return UIColor.clear
        case .white: return UIColor(hexString: "#FFFFFF")
        case .black: return UIColor(hexString: "000000")
        case .kakalYellow: return UIColor(hexString: "FEE500")
        case .naverGreen: return UIColor(hex: "03A94D")
        case .grey: return UIColor(hexString: "D9D9D9")
        }
    }
}
