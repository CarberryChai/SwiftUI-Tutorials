//
//  OffsetKey.swift
//  TaskManagement
//
//  Created by changlin on 2023/8/22.
//

import SwiftUI

struct OffsetKey:PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
