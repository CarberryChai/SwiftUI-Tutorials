//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by 柴长林 on 2022/5/14.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
  @StateObject var store: Store = .init()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(store)
    }
  }
}
