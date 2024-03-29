//
//  ContentView.swift
//  TaskManagement
//
//  Created by changlin on 8/08/23.
//

import ChaiUtil
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Task.createdAt, order: .reverse) var tasks: [Task] = []
    @State private var weekSlider: [[Date.WeekDay]] = []
    @State private var currentWeekIndex = 1
    @State private var showAddTask = false
    @State private var text = ""
    @State private var currentDate = Date()
    @Namespace private var naimation

    private var shouldCreateWeek: Bool {
        return currentWeekIndex == 0 || currentWeekIndex == (weekSlider.count - 1)
    }

    var body: some View {
        VStack {
            header

            TasksView(currentDate: $currentDate)
            .overlay(alignment: .bottomTrailing, content: {
                Button(action: {
                    showAddTask.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue, in: Circle())
                        .offset(x: -15, y: -15)
                        .shadow(radius: 10)
                })
            })
            .sheet(isPresented: $showAddTask, content: {
                NewTaskView().presentationDetents([.medium])
            })
            .onAppear {
                if weekSlider.isEmpty {
                    weekSlider = initWeek()
                }
            }
        }
    }
}

extension ContentView {
    private var header: some View {
        VStack {
            VStack(spacing: 8) {
                HStack(spacing: 6) {
                    Text(currentDate.format("MMMM"))
                        .foregroundStyle(.blue)
                    Text(currentDate.format("YYYY"))
                        .foregroundStyle(.gray)
                }
                .font(.title.bold())
                Text(currentDate.formatted(date: .complete, time: .omitted))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
            }
            .HBox(.leading)
            .overlay(alignment: .trailing) {
                Button(action: {}, label: {
                    Image(.cat)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(.circle)
                })
                .contextMenu(menuItems: {
                    Button(action: {
                        weekSlider = initWeek()
                    }, label: {
                        Label("Reset Date", systemImage: "arrow.circlepath")
                    })
                })
            }

            /// date slider
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    WeekView(week)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
        }
        .padding(.horizontal, 10)
        .background(.white, in: .rect)
    }

    @ViewBuilder
    private func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)

                    Text(day.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(currentDate.isSame(to: day.date) ? .white : .gray)
                        .frame(width: 35, height: 35)
                        .background {
                            if currentDate.isSame(to: day.date) {
                                Circle().fill(.blue.gradient)
                                    .matchedGeometryEffect(id: "select_target", in: naimation)
                            }
                            if day.date.isToday {
                                Circle().fill(.cyan)
                                    .frame(width: 5, height: 5)
                                    .VBox(.bottom)
                                    .offset(y: 12)
                            }
                        }
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                        .onTapGesture {
                            withAnimation(.snappy(duration: 0.5)) {
                                currentDate = day.date
                            }
                        }
                }
                .HBox()
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self) { value in
                        if value.rounded() == 10 && shouldCreateWeek {
                            paginateWeek()
                        }
                    }
            }
        }
    }

    private func paginateWeek() {
        if currentWeekIndex == 0, let first = weekSlider[0].first?.date {
            weekSlider.insert(first.createPreviousWeek(), at: 0)
            weekSlider.removeLast()
        }
        if currentWeekIndex == 2, let last = weekSlider[2].last?.date {
            weekSlider.append(last.createNextWeek())
            weekSlider.removeFirst()
        }
        currentWeekIndex = 1
    }

    private func initWeek() -> [[Date.WeekDay]] {
        var result: [[Date.WeekDay]] = []
        let week = currentDate.fetchWeek()

        if let firstDay = week.first?.date {
            result.append(firstDay.createPreviousWeek())
        }

        result.append(week)

        if let lastDay = week.last?.date {
            result.append(lastDay.createNextWeek())
        }
        return result
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
