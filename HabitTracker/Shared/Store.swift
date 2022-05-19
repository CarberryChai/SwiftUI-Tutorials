//
//  Store.swift
//  HabitTracker
//
//  Created by 柴长林 on 2022/5/17.
//

import SwiftUI
import CoreData

class Store: ObservableObject {
  @Published var addNewHabit = false
  
  @Published var title: String = ""
  @Published var habitColor: String = "Card-1"
  @Published var weekDays: [String] = []
  @Published var isRemainderOn: Bool = false
  @Published var remainderText: String = ""
  @Published var remainderDate: Date = Date()
  
  @Published var showDatePicker: Bool = false
  
  func addHabit(context: NSManagedObjectContext) -> Bool {
    return false
  }
  
  func resetData() {
    title = ""
    habitColor = "Card-1"
    isRemainderOn = false
    remainderText = ""
    remainderDate = Date()
  }
  
  func doneDisabled() -> Bool {
    let remainderStatus = isRemainderOn && remainderText.isEmpty
    
    return title.isEmpty || weekDays.isEmpty || remainderStatus
  }
}
