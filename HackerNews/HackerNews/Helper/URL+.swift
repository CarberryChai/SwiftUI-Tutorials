//
//  URL+.swift
//  HackerNews
//
//  Created by changlin on 2023/9/6.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: value.description)!
    }
}
