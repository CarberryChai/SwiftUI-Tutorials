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
}
