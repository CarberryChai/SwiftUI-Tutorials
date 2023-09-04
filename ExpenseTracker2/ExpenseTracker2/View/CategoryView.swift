//
//  CategoryView.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import SwiftData
import SwiftUI

struct CategoryView: View {
    @Query(animation: .snappy) var categories: [Category]
    @Environment(\.modelContext) var context
    @State private var showNew = false
    @State private var name = ""
    @State private var showAlert = false
    @State private var selectedCategory: Category?
    var body: some View {
        NavigationStack {
            List {
                if categories.isEmpty {
                    ContentUnavailableView("No Category", systemImage: "list.clipboard.fill")
                } else {
                    ForEach(categories) { category in
                        DisclosureGroup(category.name) {
                            if let expenses = category.expenses, !expenses.isEmpty {
                                ForEach(expenses) { exp in
                                    ExpenseCard(expense: exp)
                                }
                            } else {
                                ContentUnavailableView("No Expense", systemImage: "creditcard.fill")
                            }
                        }
                        .swipeActions(allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                showAlert.toggle()
                                selectedCategory = category
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showNew.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showNew) {
                NavigationStack {
                    VStack {
                        TextField("name", text: $name)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .navigationTitle("New Category")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showNew = false
                            }
                        }
                        ToolbarItem(placement: .primaryAction) {
                            Button("Done") {
                                let category = Category(name: name)
                                do {
                                    context.insert(category)
                                    try context.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                                name = ""
                                showNew = false
                            }
                            .disabled(name.isEmpty)
                        }
                    }
                }
                .presentationDetents([.height(300)])
            }
            .alert("Warning", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {
                    showAlert = false
                    selectedCategory = nil
                }
                Button("Confirm", role: .destructive) {
                    if let selectedCategory {
                        context.delete(selectedCategory)
                    }
                    selectedCategory = nil
                }
            } message: {
                Text("Deleting the category will delete all associated expenses.")
            }
        }
    }
}

#Preview {
    CategoryView()
}
