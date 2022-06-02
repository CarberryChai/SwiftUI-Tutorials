//
//  Home.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/5/22.
//

import SwiftUI

struct Home: View {
  @EnvironmentObject var store: Store
  @State private var showAdd = false
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
    .fullScreenCover(
      isPresented: $showAdd,
      onDismiss: {
        store.resetData()
        store.edittingItem = nil
      },
      content: {
        NewTransaction(show: $showAdd)
      }
    )
    .overlay(alignment: .bottomTrailing) {
      Button {
        showAdd = true
      } label: {
        Image(systemName: "plus")
          .font(.title2)
          .foregroundColor(.white)
          .padding()
          .background {
            Circle().fill(
              LinearGradient(colors: [.pink, .purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
          }
      }.padding()
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
        TransactionCard(expense: expense)
          .onTapGesture {
            store.edittingItem = expense
            store.restoreTransaction()
            showAdd = true
          }
      }
    }.padding(.top)
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Store())
  }
}
