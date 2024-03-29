//
//  NewExpense.swift
//  ExpenseTracker2
//
//  Created by changlin on 2023/9/4.
//

import SwiftData
import SwiftUI

struct NewExpense: View {
    @Environment(\.modelContext) var context
    @State private var title = ""
    @State private var subtitle = ""
    @State private var amount: CGFloat = 0
    @State private var date = Date()
    @State private var category: Category?
    @Environment(\.dismiss) var dismiss
    @Query() private var allCategories: [Category]

    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Mac mini", text: $title)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                Section("Subtitle") {
                    TextField("This product bought from apple store", text: $subtitle)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                Section("Price") {
                    TextField("$0.0", value: $amount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                }
                Section("Date") {
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                // Picker, selection的类型必须于每一个所选择的元素的tag指定类型相同， 不是Optional的，要cast到可选类型。
                Picker("Category", selection: $category) {
                    ForEach(allCategories) {c in
                        Text(c.name).tag(Optional(c))
                    }
                    Text("None").tag(nil as Category?)
                }
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        resetAll()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let exp = Expense(title: title, subtitle: subtitle, amount: amount, date: date, category: category)
                        context.insert(exp)
                        resetAll()
                        dismiss()
                    }
                    .disabled(isBtnDisable)
                }
            }
        }
    }
}

extension NewExpense {
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }

    private var isBtnDisable: Bool {
        return title.isEmpty || subtitle.isEmpty || amount == 0
    }

    private func resetAll() {
        title = ""
        subtitle = ""
        amount = 0
        date = .init()
        category = nil
    }
}
