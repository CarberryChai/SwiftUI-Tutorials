//
//  Category.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import SwiftUI
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var id: String
    var name: String

    @Relationship(deleteRule: .cascade, inverse: \Expense.category) var expenses: [Expense]?

    init(name: String, expenses: [Expense]? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.expenses = expenses
    }
}
