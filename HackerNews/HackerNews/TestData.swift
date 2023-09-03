//
//  TestData.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import Foundation


struct TestData {
    static let story: StoryItem = {
        let url = Bundle.main.url(forResource: "story", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try! decoder.decode(StoryItem.self, from: data)
    }()
}
