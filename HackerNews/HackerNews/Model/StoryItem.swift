//
//  StoryItem.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import Foundation

struct StoryItem: Identifiable {
    let id: Int
    let commentCount: Int
    let score: Int
    let author: String
    let title: String
    let url: URL
    let date: Date
}

extension StoryItem: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, score, title, url
        case author = "by"
        case date = "time"
        case commentCount = "descendants"
    }
}
