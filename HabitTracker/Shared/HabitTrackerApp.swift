//
//  HabitTrackerApp.swift
//  Shared
//
//  Created by 柴长林 on 2022/5/17.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
  let persistenceController = PersistenceController.shared
  @StateObject var store: Store
  
  init() {
    _store = .init(wrappedValue: Store())
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
        .environmentObject(store)
        .preferredColorScheme(store.isColorSchemeDark ? .dark : .light)
    }
  }
}
