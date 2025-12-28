//
//  Account.swift
//  Joobjoob
//
//  Created by zehye on 12/27/25.
//

import Foundation

struct Account: Codable {
    var platform: Platform
    var id: String
}

enum Platform: String, Codable, CaseIterable {
    case apple
    case google
    case kakao
    case naver
}
