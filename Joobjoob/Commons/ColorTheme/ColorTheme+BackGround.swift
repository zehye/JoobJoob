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
    }
}

// MARK: ColorTheme.LightTheme + Background
extension ColorTheme.LightTheme {
    static func background(_ type: ColorTheme.Background) -> UIColor {
        switch type {
        case .background: return UIColor(hexString: "28682B")
        case .clear: return UIColor.clear
        case .white: return UIColor(hexString: "#FFFFFF")
        }
    }
}
