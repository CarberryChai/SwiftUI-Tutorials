//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/27.
//

import SwiftData
import SwiftUI

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
