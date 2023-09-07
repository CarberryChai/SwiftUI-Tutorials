//
//  ContentView.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.store) var store
    @State private var errorInfo: Error?
    @State private var showError = false
    var body: some View {
        NavigationStack {
            List {
                if store.stories.isEmpty {
                    ContentUnavailableView("No News", systemImage: "newspaper.fill")
                } else {
                    ForEach(store.stories.indices, id: \.self) { index in
                        NewsRowView(story: store.stories[index], index: index + 1)
                    }
                }
            }
            .navigationTitle("HackerNews")
            .task {
                do {
                    try await store.getAllStories()
                } catch {
                    errorInfo = error
                }
            }
//            .alert(isPresented: $showError, error: errorInfo) {
//
//            }
        }
    }
}
