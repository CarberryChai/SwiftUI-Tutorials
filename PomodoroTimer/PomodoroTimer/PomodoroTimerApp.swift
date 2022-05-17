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
  @Environment(\.scenePhase) var phase
  @State var lastActiveTimeStamp = Date()
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(store)
    }
    .onChange(of: phase) { newValue in
      if store.isStarted {
        if newValue == .background {
          lastActiveTimeStamp = Date()
        }
        if newValue == .active {
          let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
          if store.totalSeconds - Int(currentTimeStampDiff) <= 0 {
            store.reset()
          } else {
            store.totalSeconds -= Int(currentTimeStampDiff)
          }
        }
      }
    }
  }
}
