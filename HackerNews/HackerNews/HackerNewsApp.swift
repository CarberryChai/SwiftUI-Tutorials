//
//  HackerNewsApp.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import SwiftUI

@main
struct HackerNewsApp: App {
    @State private var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(\.store, store)
    }
}
