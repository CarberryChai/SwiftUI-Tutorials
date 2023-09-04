//
//  CategoryView.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    @Query(animation: .snappy) var categories: [Category]
    var body: some View {
        NavigationStack {
            List {
                if categories.isEmpty {
                    ContentUnavailableView("No Category", systemImage: "list.clipboard.fill")
                } else {
                    ForEach(categories) {category in
                        DisclosureGroup(category.name) {
                            if let expenses = category.expenses, expenses.isEmpty {
                                ContentUnavailableView("No Expense", systemImage: "creditcard.fill")
                            } else {
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Categories")
        }
    }
}

#Preview {
    CategoryView()
}
