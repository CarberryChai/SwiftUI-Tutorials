//
//  CategoryView.swift
//  ExpenseTracker3
//
//  Created by changlin on 2023/9/19.
//

import SwiftUI

struct CategoryView: View {
  @State private var showNew = false
  @State private var name = ""
  var body: some View {
    NavigationStack {
      List {}
        .navigationTitle("Category")
        .toolbar {
          ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
              showNew.toggle()
            }, label: {
              Image(systemName: "plus.circle")
            })
          }
        }
        .alert("Enter a Category", isPresented: $showNew) {
          TextField("name", text: $name)
          Button("Cancel", role: .cancel) {
            showNew.toggle()
          }
          Button("Done") {

          }
        }
    }
  }
}

#Preview {
  ContentView()
}
