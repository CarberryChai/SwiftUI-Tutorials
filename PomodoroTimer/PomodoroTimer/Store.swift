//
//  Store.swift
//  PomodoroTimer
//
//  Created by 柴长林 on 2022/5/14.
//

import SwiftUI

class Store: ObservableObject {
  @Published var progress: CGFloat = 1
  @Published var isStarted = false
  @Published var addNew = false

  @Published var timerString = "00:00"
  @Published var hour: Int = 0
  @Published var minute: Int = 0
  @Published var second: Int = 0
}
