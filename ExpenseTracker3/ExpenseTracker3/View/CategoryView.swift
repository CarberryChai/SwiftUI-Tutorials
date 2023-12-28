//
//  CategoryView.swift
//  ExpenseTracker3
//
//  Created by changlin on 2023/9/19.
//

import SwiftUI
import CoreData

struct CategoryView: View {
  @State private var showNew = false
  @State private var name = ""
  @Environment(\.persistentProvider) var persistent
  @FetchRequest(entity: Category.entity(), sortDescriptors: [.init(keyPath: \Category.name, ascending: true)])
  var categories: FetchedResults<Category>
  var body: some View {
    NavigationStack {
      List {
        if categories.isEmpty {
          ContentUnavailableView("No Category", systemImage: "list.clipboard.fill")
        } else {
          ForEach(categories) {category in
            DisclosureGroup(category.name ?? "") {
              if category.expenses.isEmpty {

              }
            }
          }
        }
      }
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
            persistent.saveCategory(name)
          }
          .disabled(name.isEmpty)
        }
    }
  }
}

#Preview {
  ContentView()
}
