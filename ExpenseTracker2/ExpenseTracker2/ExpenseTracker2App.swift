//
//  ExpenseTracker2App.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import SwiftUI
import SwiftData

@main
struct ExpenseTracker2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self, Category.self])
    }
}
