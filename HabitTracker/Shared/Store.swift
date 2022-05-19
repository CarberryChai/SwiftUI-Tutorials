//
//  Store.swift
//  HabitTracker
//
//  Created by 柴长林 on 2022/5/17.
//

import CoreData
import SwiftUI

@MainActor
class Store: ObservableObject {
  @Published var addNewHabit = false
  @Published var showSetting = false
  
  @AppStorage("habit-color-scheme") var isColorSchemeDark = true {
    didSet {
      objectWillChange.send()
    }
  }
  
  @Published var title: String = ""
  @Published var habitColor: String = "Card-1"
  @Published var weekDays: [String] = []
  @Published var isRemainderOn: Bool = false
  @Published var remainderText: String = ""
  @Published var remainderDate: Date = Date()
  
  @Published var notificationAccess: Bool = false
  @Published var showDatePicker: Bool = false
  
  @Published var edittingHabit: Habit?
  
  init() {
    Task {
      await requestNotificationAccess()
    }
  }
  
  func requestNotificationAccess() async {
    if let status = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
      self.notificationAccess = status
    }
  }

  func addHabit(context: NSManagedObjectContext)async -> Bool {
    var habit: Habit
    if let edittingHabit = edittingHabit {
      habit = edittingHabit
      // remove this habit all pending notifications
      UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: habit.notificationIDs ?? [])
    } else {
      habit = Habit(context: context)
    }
    habit.title = title
    habit.color = habitColor
    habit.weekDays = weekDays
    habit.isRemainderOn = isRemainderOn
    habit.remainderText = remainderText
    habit.notificationDate = remainderDate
    habit.notificationIDs = []

    if isRemainderOn {
      if let ids = try? await scheduleNotification() {
        habit.notificationIDs = ids
        if let _ = try? context.save() {
          return true
        }
      }
    } else {
      if let _ = try? context.save() {
        return true
      }
    }
    return false
  }
  
  func restoreEditData() {
    if let habit = edittingHabit {
      title = habit.title ?? ""
      habitColor = habit.color ?? "Card-1"
      weekDays = habit.weekDays ?? []
      isRemainderOn = habit.isRemainderOn
      remainderText = habit.remainderText ?? ""
      remainderDate = habit.notificationDate ?? Date()
    }
  }
  
  // delete habit from database
  func deleteHabit(contxt: NSManagedObjectContext) -> Bool {
    if let editHabit = edittingHabit {
      if editHabit.isRemainderOn {
        // remove this habit all pending notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: editHabit.notificationIDs ?? [])
      }
      contxt.delete(editHabit)
      if let _ = try? contxt.save() {
        return true
      }
    }
    return false
  }

  func scheduleNotification() async throws -> [String] {
    let content = UNMutableNotificationContent()
    content.title = "Habit Remainder"
    content.body = remainderText
    content.sound = UNNotificationSound.default

    var notificationIDs: [String] = []
    let calendar = Calendar.current
    let weekdaySymbols: [String] = calendar.shortWeekdaySymbols

    for weekDay in weekDays {
      let id = UUID().uuidString
      let hour = calendar.component(.hour, from: remainderDate)
      let min = calendar.component(.minute, from: remainderDate)
      let day = weekdaySymbols.firstIndex(where: { $0 == weekDay }) ?? -1

      if day != -1 {
        var components = DateComponents()
        components.hour = hour
        components.minute = min
        components.day = day + 1

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        try await UNUserNotificationCenter.current().add(request)
        notificationIDs.append(id)
      }
    }
    return notificationIDs
  }

  func resetData() {
    title = ""
    habitColor = "Card-1"
    weekDays = []
    isRemainderOn = false
    remainderText = ""
    remainderDate = Date()
  }

  func doneDisabled() -> Bool {
    let remainderStatus = isRemainderOn && remainderText.isEmpty

    return title.isEmpty || weekDays.isEmpty || remainderStatus
  }
}
