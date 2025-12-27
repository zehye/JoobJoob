//
//  ColorTheme+BackGround.swift
//  Joobjoob
//
//  Created by zehye on 12/26/25.
//

import UIKit

// MARK: ColorTheme + Background
extension ColorTheme {
    convenience init(background type: Background) {
        self.init(light: LightTheme.background(type), dark: DarkTheme.background(type))
    }
}

// MARK: ColorThemeable + Background
extension ColorThemeable {
    static func background(_ type: ColorTheme.Background) -> UIColor { return .clear }
}

// MARK: ColorTheme + Background
extension ColorTheme {
    enum Background {
        case background
        case clear
        case white
        case black
        case kakalYellow
        case naverGreen
        case grey
    }
}

// MARK: ColorTheme.LightTheme + Background
extension ColorTheme.LightTheme {
    static func background(_ type: ColorTheme.Background) -> UIColor {
        switch type {
        case .background: return UIColor(hexString: "28682B")
        case .clear: return UIColor.clear
        case .white: return UIColor(hexString: "#FFFFFF")
        case .black: return UIColor(hexString: "000000")
        case .kakalYellow: return UIColor(hexString: "FEE500")
        case .naverGreen: return UIColor(hexString: "03A94D")
        case .grey: return UIColor(hexString: "6C7278")
        }
    }
}
