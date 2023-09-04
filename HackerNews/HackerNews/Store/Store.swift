//
//  Store.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import SwiftUI

@Observable
final class Store {
    var stories: [StoryItem] = []

    func getAllStories(_ ids: [Int]) async -> [StoryItem] {
        return await withTaskGroup(of: [StoryItem].self) { _ in
            for id in ids {}
        }
    }

    func getStory(_ id: Int) async throws -> StoryItem {
        let endpoint = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!
        let (data, response) = try await URLSession.shared.data(from: endpoint)
        guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else { throw URLError(.badServerResponse) }
        return try JSONDecoder().decode(StoryItem.self, from: data)
    }
}
