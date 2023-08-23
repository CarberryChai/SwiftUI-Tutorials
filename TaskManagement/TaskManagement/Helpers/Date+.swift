//
//  Date+.swift
//  TaskManagement
//
//  Created by changlin on 9/08/23.
//

import Foundation

extension Date {
    func format(_ partern: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = partern
        return formater.string(from: self)
    }

    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)

        var week: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDay)

        guard let startOfWeek = weekForDate?.start else { return [] }

        (0 ..< 7).forEach { idx in
            if let weekDay = calendar.date(byAdding: .day, value: idx, to: startOfWeek) {
                week.append(.init(date: weekDay))
            }
        }
        return week
    }

    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        guard let nextDay = calendar.date(byAdding: .day, value: 1, to: self) else { return [] }
        return fetchWeek(nextDay)
    }
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        guard let nextDay = calendar.date(byAdding: .day, value: -1, to: self) else { return [] }
        return fetchWeek(nextDay)
    }

    struct WeekDay: Identifiable {
        var id = UUID()
        var date: Date
    }

    func isSame(to date: Self) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
}
