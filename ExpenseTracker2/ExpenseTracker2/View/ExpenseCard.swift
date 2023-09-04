//
//  ExpenseCard.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import SwiftUI

struct ExpenseCard: View {
    let expense: Expense
    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                Text(expense.title)
                    .fontWeight(.semibold)

                Text(expense.subtitle)
                    .font(.caption)
            }
            .lineLimit(1)
            .truncationMode(.tail)

            Spacer()

            Text(expense.currencyString)
                .font(.title2.bold())
        }
    }
}
