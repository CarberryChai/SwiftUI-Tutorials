//
//  NewTaskView.swift
//  TaskManagement
//
//  Created by changlin on 2023/8/23.
//

import SwiftData
import SwiftUI

struct NewTaskView: View {
    @State private var text = ""
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var selectedDate: Date = .init()
    var body: some View {
        VStack(spacing: 40) {
            Text("Add New Task")
                .font(.title.bold())

            TextField("input your task", text: $text, axis: .vertical)
                .lineLimit(1 ... 3)
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))

            DatePicker("Select a date: ", selection: $selectedDate)
                .datePickerStyle(.compact)

            Spacer()

            submitButton
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(alignment: .topTrailing) {
            Button(role: .destructive, action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .padding()
            })
        }
    }
}

extension NewTaskView {
    private var submitButton: some View {
        Button(action: {
            let t = Task(content: text.trimmingCharacters(in: .whitespacesAndNewlines), createdAt: selectedDate)
            context.insert(t)
            dismiss()
            text = ""
            selectedDate = .init()
        }, label: {
            Text("Save")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .foregroundStyle(.white)
                .background(.blue.gradient, in: RoundedRectangle(cornerRadius: 10))
        })
        .disabled(text.isEmpty)
        .opacity(text.isEmpty ? 0.5 : 1)
    }
}

#Preview {
    NewTaskView()
}
