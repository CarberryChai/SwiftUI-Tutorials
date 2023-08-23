//
//  TasksView.swift
//  TaskManagement
//
//  Created by changlin on 2023/8/23.
//

import SwiftData
import SwiftUI

struct TasksView: View {
    @Binding var date: Date
    @Query private var tasks: [Task]

    init(currentDate: Binding<Date>) {
        self._date = currentDate
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: currentDate.wrappedValue)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        let predicate = #Predicate<Task> {
            $0.createdAt >= start && $0.createdAt < end
        }
        let sortDescriptor = [SortDescriptor(\Task.createdAt, order: .reverse)]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .bouncy)
    }

    var body: some View {
        ScrollView(.vertical) {
            if tasks.isEmpty {
                ContentUnavailableView("No Tasks", systemImage: "note.text")
            } else {
                ForEach(tasks) { task in
                    TaskRowView(task: task)
                        .background {
                            if tasks.last?.id != task.id {
                                Rectangle().frame(width: 1).HBox(.leading)
                                    .offset(x: 8)
                                    .padding(.bottom, -35)
                            }
                        }
                }
            }
        }
        .padding([.horizontal], 10)
        .contentMargins(.vertical, 15)
    }
}

#Preview {
    TasksView(currentDate: .constant(Date()))
}
