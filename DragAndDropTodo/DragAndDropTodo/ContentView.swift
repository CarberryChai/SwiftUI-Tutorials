//
//  ContentView.swift
//  DragAndDropTodo
//
//  Created by changlin on 24/07/23.
//

import Algorithms
import SwiftUI

struct ContentView: View {
    @State private var todos: [Todo] = Todo.mockData
    @State private var processTodos: [Todo] = []
    @State private var finishedTodos: [Todo] = []
    var body: some View {
        HStack(spacing: 15) {
            KanbanView(todos: todos, type: .all)
                .dropDestination(for: Todo.self) { items, _ in
                    todos = filterTodo(.all, items: items)
                    for item in items {
                        processTodos.removeAll(where: { $0.id == item.id })
                        finishedTodos.removeAll(where: { $0.id == item.id })
                    }
                    return true
                }

            KanbanView(todos: processTodos, type: .process)
                .dropDestination(for: Todo.self) { items, _ in
                    processTodos = filterTodo(.process, items: items)
                    for item in items {
                        todos.removeAll(where: { $0.id == item.id })
                        finishedTodos.removeAll(where: { $0.id == item.id })
                    }
                    return true
                }
            KanbanView(todos: finishedTodos, type: .done)
                .dropDestination(for: Todo.self) { items, _ in
                    finishedTodos = filterTodo(.done, items: items)
                    for item in items {
                        todos.removeAll(where: { $0.id == item.id })
                        processTodos.removeAll(where: { $0.id == item.id })
                    }
                    return true
                }
        }
    }
}

extension ContentView {
    private func filterTodo(_ type: TodoStatus, items: [Todo]) -> [Todo] {
        var result = switch type {
        case .all:
            todos
        case .process:
            processTodos
        case .done:
            finishedTodos
        }
        result.append(contentsOf: items)

        return Array(result.uniqued())
    }
}

#Preview {
    ContentView()
}
