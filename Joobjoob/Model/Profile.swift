//
//  Profile.swift
//  Joobjoob
//
//  Created by zehye on 12/27/25.
//

import Foundation

struct Profile: Codable {
    var nickname: String
    var birthDate: String
    var birthTime: String?
    var isLunarCalendar: Bool
    var gender: Gender
    var isMarried: Bool
    var hasChildren: Bool
}

enum Gender: String, Codable {
    case male
    case female
}
