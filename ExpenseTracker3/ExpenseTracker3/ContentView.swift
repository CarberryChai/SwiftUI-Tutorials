//
//  ContentView.swift
//  ExpenseTracker3
//
//  Created by changlin on 2023/9/18.
//

import SwiftUI

struct ContentView: View {
  @State private var curTab: Tab = .Category
  var body: some View {
    TabView(selection: $curTab) {
      ForEach(Tab.allCases) { tab in
        tab.destination.tag(tab).tabItem { tab.label }
      }
    }
  }
}

private enum Tab: CaseIterable, Identifiable {
  case Expense, Category

  @ViewBuilder
  var destination: some View {
    switch self {
      case .Expense:
        ExpenseView()
      case .Category:
        CategoryView()
    }
  }

  @ViewBuilder
  var label: some View {
    switch self {
      case .Expense:
        Label("Expense", systemImage: "creditcard.fill")
      case .Category:
        Label("Category", systemImage: "list.clipboard.fill")
    }
  }

  var id: Self { self }
}

#Preview {
  ContentView()
}
