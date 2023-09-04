//
//  extension+.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import Foundation

extension Date {
    func isSameDay(_ day: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: day)
    }
}
