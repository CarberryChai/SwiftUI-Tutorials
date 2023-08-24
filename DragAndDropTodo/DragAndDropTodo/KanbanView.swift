//
//  KanbanView.swift
//  DragAndDropTodo
//
//  Created by changlin on 2023/8/24.
//

import SwiftUI

enum TodoStatus: String, CaseIterable, Identifiable {
    case all, process, done

    var id: Self { self }

    var color: Color {
        switch self {
            case .all:
                return .gray.opacity(0.5)
            case .process:
                return .indigo
            case .done:
                return .green
        }
    }
}

struct KanbanView: View {
    let todos: [Todo]
    var type: TodoStatus = .all
    var body: some View {
        VStack {
            Text("\(type.rawValue)".uppercased())
                .font(.title.bold())

            VStack(alignment: .leading, spacing: 10) {
                ForEach(todos) { todo in
                    Text(todo.content)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.white.shadow(.drop(radius: 1)), in: .rect(cornerRadius: 8))
                        .draggable(todo)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(type.color, in: .rect(cornerRadius: 20))
        }
    }
}

#Preview {
    KanbanView(todos: Todo.mockData)
}
