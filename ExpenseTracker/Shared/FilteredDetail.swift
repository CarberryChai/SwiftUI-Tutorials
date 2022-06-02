//
//  FilteredDetail.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/5/26.
//

import SwiftUI

struct FilteredDetail: View {
  @EnvironmentObject var store: Store
  @Environment(\.self) var env
  @Namespace var animation
  @State private var showFilter = false
  @State private var tabType: ExpenseType = .income
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 12) {
        Header
        ExpenseCard()
        ExpenseTab
        VStack(spacing: 15) {
          Text(store.rangeString)
            .opacity(0.7)
          Text(
            tabType == .income
              ? store.convertExpenseToCurrency(store.totalIncome) : store.convertExpenseToCurrency(store.totalExpense)
          )
          .fontWeight(.bold)
          .opacity(0.9)
          .animation(.none, value: store.type)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
          RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
        }
        .padding(.vertical, 20)

        ForEach(store.expenses.filter({ $0.type == tabType.rawValue })) { expense in
          TransactionCard(expense: expense)
        }
      }.padding()
    }
    .overlay {
      if showFilter {
        FilterCard
      }
    }
    .navigationBarHidden(true)
    .background {
      Color("bgc").ignoresSafeArea()
    }
  }

  var FilterCard: some View {
    ZStack {
      Color.black.opacity(0.2)
        .onTapGesture {
          showFilter = false
        }
      HStack(spacing: 10) {
        DatePicker("Start", selection: $store.startDate, displayedComponents: [.date])
          .datePickerStyle(.compact)
        Text("-")
        DatePicker("End", selection: $store.endDate, displayedComponents: [.date])
          .datePickerStyle(.compact)
      }
      .padding(.vertical, 35)
      .padding(.horizontal)
      .background {
        RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.white)
      }
      .padding(.horizontal, 15)
    }
  }

  var Header: some View {
    HStack(spacing: 15) {
      IconButton(systemName: "arrow.backward.circle.fill") {
        env.dismiss()
      }
      Text("Transactions")
        .font(.title2.bold())
        .opacity(0.7)
        .frame(maxWidth: .infinity, alignment: .leading)

      IconButton(systemName: "slider.horizontal.3") {
        showFilter = true
      }
    }
  }

  var ExpenseTab: some View {
    HStack(spacing: 0) {
      ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) { type in
        Text(type.rawValue)
          .fontWeight(.semibold)
          .foregroundColor(tabType == type ? .white : .black)
          .opacity(tabType == type ? 1 : 0.7)
          .padding(.vertical, 12)
          .frame(maxWidth: .infinity)
          .background {
            if tabType == type {
              RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(
                  LinearGradient(colors: [.pink, .purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .matchedGeometryEffect(id: "tab", in: animation)
            }
          }
          .onTapGesture {
            withAnimation(.spring()) {
              tabType = type
            }
          }
      }
    }
    .padding(5)
    .background {
      RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
    }
  }

  private func IconButton(systemName: String, _ handler: @escaping () -> Void) -> some View {
    Button(action: handler) {
      Image(systemName: systemName)
        .font(.caption.bold())
        .foregroundColor(.gray)
        .frame(width: 40, height: 40)
        .background {
          RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
        }
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 0)
    }
  }
}

struct FilteredDetail_Previews: PreviewProvider {
  static var previews: some View {
    FilteredDetail()
      .environmentObject(Store())
  }
}
