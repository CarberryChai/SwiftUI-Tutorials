//
//  ExpenseTrackerApp.swift
//  Shared
//
//  Created by 柴长林 on 2022/5/21.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
  @StateObject var store: Store
  init() {
    _store = .init(wrappedValue: Store())
  }
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(store)
    }
  }
}
