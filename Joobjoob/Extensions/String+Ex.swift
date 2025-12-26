//
//  String.swift
//  Joobjoob
//
//  Created by zehye on 12/26/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
