//
//  TransactionCard.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/5/31.
//

import SwiftUI

struct TransactionCard: View {
  @EnvironmentObject var store: Store
  let expense: Expense
  
  var body: some View {
    HStack(spacing: 12) {
      if let first = expense.remark?.first {
        Text(String(first))
          .font(.title.bold())
          .foregroundColor(.white)
          .frame(width: 30, height: 30)
          .background {
            Circle().fill(Color(expense.color ?? "c-1"))
          }
      }
      
      Text(expense.remark ?? "")
        .fontWeight(.semibold)
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      VStack(alignment: .trailing, spacing: 7) {
        Text(store.convertExpenseToCurrency(expense.type == "income" ? expense.amount : -expense.amount))
          .font(.callout)
          .opacity(0.7)
          .foregroundColor(expense.type == ".income" ? .green : .red)
        
        Text(expense.date?.formatted(date: .numeric, time: .omitted) ?? "")
          .font(.caption)
          .opacity(0.5)
      }
    }
    .padding()
    .background {
      RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
    }
  }
}
