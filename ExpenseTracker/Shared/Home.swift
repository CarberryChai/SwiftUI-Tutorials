//
//  Home.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/5/22.
//

import SwiftUI

struct Home: View {
  @EnvironmentObject var store: Store
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 12) {
        header
        ExpenseCard()
        transactions
      }
    }
    .padding()
    .background {
      Color("bgc").ignoresSafeArea()
    }
  }

  var header: some View {
    HStack {
      VStack(alignment: .leading, spacing: 6) {
        Text("Welcome")
          .font(.caption)
          .fontWeight(.semibold)
          .foregroundColor(.gray)

        Text("IJustine")
          .font(.title2.bold())
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      NavigationLink {
        FilteredDetail()
      } label: {
        Image(systemName: "hexagon.fill")
          .foregroundColor(.gray)
          .overlay {
            Circle().stroke(.white, lineWidth: 2).padding(7)
          }
          .frame(width: 40, height: 40)
          .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
          .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 0)
      }

    }
  }

  var transactions: some View {
    VStack(spacing: 12) {
      Text("Transactions")
        .font(.title2.bold())
        .opacity(0.7)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)

      ForEach(store.expenses) { expense in
        transactionCard(expense: expense)
      }
    }.padding(.top)
  }

  func transactionCard(expense: Expense) -> some View {
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
        Text(store.convertExpenseToCurrency(expense.type == ".income" ? expense.amount : -expense.amount))
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

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Store())
  }
}
