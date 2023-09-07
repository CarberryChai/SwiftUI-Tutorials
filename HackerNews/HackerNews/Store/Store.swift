//
//  Store.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import SwiftUI

@Observable
final class Store {
    let session = URLSession(configuration: .default)

    var stories: [StoryItem] = []

    func getAllStories() async throws {
        let endpoint = URL(stringLiteral: "https://hacker-news.firebaseio.com/v0/topstories.json")
        let data = try await session.data(for: URLRequest(url: endpoint))
        let ids = try (JSONDecoder().decode([Int].self, from: data)).prefix(10)

        stories = try await withThrowingTaskGroup(of: StoryItem.self, returning: [StoryItem].self) { group in
            ids.forEach { id in
                group.addTask { try await self.getStory(id) }
            }
            return try await group.reduce(into: [StoryItem]()) { $0.append($1) }
        }
    }

    func getStory(_ id: Int) async throws -> StoryItem {
        let endpoint = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
        let data = try await session.data(for: URLRequest(url: endpoint))
        return try JSONDecoder().decode(StoryItem.self, from: data)
    }
}

extension Store {
    enum NewsError: LocalizedError {
        
    }
}

struct StoreKey: EnvironmentKey {
    static var defaultValue = Store()
}

extension EnvironmentValues {
    var store: Store {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}
