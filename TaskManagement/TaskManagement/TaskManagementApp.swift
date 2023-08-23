//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by changlin on 8/08/23.
//

import SwiftUI
import SwiftData

@main
struct TaskManagementApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
