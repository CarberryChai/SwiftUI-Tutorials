//
//  extension+.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import Foundation

extension URL {
    var formatted: String {
        (host() ?? "").replacingOccurrences(of: "www.", with: "")
    }
}

extension Int {
    var formatted: String {
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Date {
    var timeAgo: String {
        let formater = RelativeDateTimeFormatter()
        formater.unitsStyle = .short
        return formater.localizedString(for: self, relativeTo: .now)
    }
}
