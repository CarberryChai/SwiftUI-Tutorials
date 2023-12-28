//
//  ExpenseView.swift
//  ExpenseTracker3
//
//  Created by changlin on 2023/9/19.
//

import SwiftUI
import CoreData

struct ExpenseView: View {
    var body: some View {
      NavigationStack {
        ZStack {
          Image(systemName: "suit.heart.fill")
            .font(.system(size: 100))
            .foregroundStyle(.red.gradient)
        }
        .frame(maxWidth: 350, maxHeight: 350)
        .background(.bar, in: .rect(cornerRadius: 30))
        .navigationTitle("Expense")
      }
    }
}

#Preview {
    ContentView()
}
