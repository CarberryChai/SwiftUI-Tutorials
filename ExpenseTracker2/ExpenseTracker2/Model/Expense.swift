//
//  Expense.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//
import SwiftUI
import SwiftData

@Model
final class Expense {
    @Attribute(.unique) var id: String
    var title: String
    var subtitle: String
    var amount: Double
    var date: Date

    var category: Category?

    @Transient var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: .init(value: amount)) ?? ""
    }

    init(title: String, subtitle: String, amount: Double, date: Date, category: Category? = nil) {
        self.id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.date = date
        self.category = category
    }
}
