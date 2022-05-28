//
//  ExpenseCard.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/5/26.
//

import SwiftUI

struct ExpenseCard: View {
  @EnvironmentObject var store: Store
  var body: some View {
    GeometryReader { proxy in
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .fill(LinearGradient(colors: [.pink, .purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))

      VStack(spacing: 12) {
        Text(store.currentMonthRangeString)
          .font(.callout)
          .fontWeight(.semibold)

        Text(store.convertExpenseToCurrency(store.totalSum))
          .font(.system(size: 35, weight: .bold))
          .lineLimit(1)
          .padding(.bottom, 5)

        HStack(spacing: 12) {
          Image(systemName: "arrow.down")
            .font(.caption.bold())
            .foregroundColor(.green)
            .frame(width: 30, height: 30)
            .background(Circle().fill(.white.opacity(0.7)))
          VStack {
            Text("Income").font(.caption).opacity(0.7)
            Text(store.convertExpenseToCurrency(store.totalIncome)).font(.callout)
          }
          .frame(maxWidth: .infinity, alignment: .leading)

          Image(systemName: "arrow.up")
            .font(.caption.bold())
            .foregroundColor(.green)
            .frame(width: 30, height: 30)
            .background(Circle().fill(.white.opacity(0.7)))
          VStack {
            Text("Expense").font(.caption).opacity(0.7)
            Text(store.convertExpenseToCurrency(store.totalExpense)).font(.callout)
          }
        }
        .padding(.horizontal)
        .padding(.trailing)
        .offset(y: 15)
      }
      .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
    }
    .frame(height: 220)
    .padding(.top)
    .foregroundColor(.white)
  }
}

struct ExpenseCard_Previews: PreviewProvider {
  static var previews: some View {
    ExpenseCard()
  }
}
