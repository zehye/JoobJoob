//
//  AccountType.swift
//  Joobjoob
//
//  Created by zehye on 12/27/25.
//


import Foundation

enum AccountType: String {
    case naver = "NAVER" // 네이버
    case kakao = "KAKAO" // 카카오
    case apple = "APPLE" // 애플
    case google = "GOOGLE"

    static var all: [AccountType] {
        return [.naver, .kakao, .apple, .google]
    }

    static func value(_ value: String) -> AccountType? {
        if let index = self.all.firstIndex(where: { $0.rawValue == value }) {
            return self.all[index]
        } else {
            return nil
        }
    }
}
