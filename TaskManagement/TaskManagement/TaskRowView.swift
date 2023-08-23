//
//  TaskRowView.swift
//  TaskManagement
//
//  Created by changlin on 2023/8/23.
//

import SwiftUI

struct TaskRowView: View {
    @Bindable var task: Task
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle().fill(.blue)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(radius: 2)), in: .circle)

            VStack(alignment: .leading, spacing: 8, content: {
                Text(task.content)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)

                Label(Date.now.format("HH:mm"), systemImage: "clock")
            })
            .HBox(.leading)
            .padding(15)
            .background(task.isCompleted ? .green.opacity(0.6) : .red.opacity(0.6), in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            .offset(y: -8)
        }
        .HBox(.leading)
    }
}

#Preview {
    TasksView(currentDate: .constant(.init()))
}
