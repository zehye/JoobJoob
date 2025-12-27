//
//  UIFont+Ex.swift
//  Joobjoob
//
//  Created by zehye on 12/27/25.
//

import UIKit

/// Custom Font 설정
extension UIFont {
    public enum SpoqaHanSansNeoType {
        case bold
        case light
        case medium
        case regular
        case thin
        
        var name: String {
            switch self {
            case .bold: return "SpoqaHanSansNeo-Bold"
            case .light: return "SpoqaHanSansNeo-Light"
            case .medium: return "SpoqaHanSansNeo-Medium"
            case .regular: return "SpoqaHanSansNeo-Regular"
            case .thin: return "SpoqaHanSansNeo-Thin"
            }
        }
    }
    
    class func spoqaHanSansNeo(type: SpoqaHanSansNeoType, size: CGFloat) -> UIFont! {
        guard let font = UIFont(name: type.name, size: size) else { return nil }
        return font
    }
}
