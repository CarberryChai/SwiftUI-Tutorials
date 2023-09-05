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
    @Attribute(.unique) var name: String

    @Relationship(deleteRule: .cascade, inverse: \Expense.category) var expenses: [Expense]?

    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}

extension Category: Identifiable {}
