//
//  ExpenseView.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import Algorithms
import SwiftData
import SwiftUI

struct ExpenseView: View {
    @Query(sort: \Expense.date, order: .reverse) var allExpenses: [Expense]
    @State private var showNew = false
    var body: some View {
        let groupedExpenses = allExpenses.chunked(by: { $0.date.isSameDay($1.date) })
        NavigationStack {
            List {
                if allExpenses.isEmpty {
                    ContentUnavailableView("No Expenses", systemImage: "creditcard.fill")
                } else {
                    ForEach(groupedExpenses, id: \.self) { group in
                        let date = group[group.startIndex].date
                        Section {
                            ForEach(group) { exp in
                                ExpenseCard(expense: exp)
                            }
                        } header: {
                            Text(date, style: .date)
                        }
                    }
                }
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showNew.toggle() }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            }
            .sheet(isPresented: $showNew, content: {
                NewExpense()
            })
        }
    }
}
