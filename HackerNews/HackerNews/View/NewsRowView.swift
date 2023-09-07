//
//  NewsRowView.swift
//  HackerNews
//
//  Created by changlin on 2023/9/6.
//

import SwiftUI

struct NewsRowView: View {
    let story: StoryItem
    let index: Int
    var body: some View {
        HStack(alignment: .top,spacing: 15) {
            Position(index: index)
            VStack(alignment: .leading, spacing: 10) {
                Text(story.title)
                    .font(.headline)
                Text(footnot)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                HStack(spacing: 20) {
                    Badge(text: story.score.formatted, imageName: "arrowtriangle.up.circle")
                        .foregroundColor(.teal)
                    Badge(text: story.commentCount.formatted, imageName: "ellipses.bubble")
                        .foregroundColor(.orange)
                }
                .font(.callout)
                .padding(.bottom)
            }
        }
    }
}

extension NewsRowView {
    private var footnot: String {
        return story.url.formatted + " - \(story.date.timeAgo)" + " - by \(story.author)"
    }

    struct Position: View {
        let index: Int
        var body: some View {
            ZStack {
                Circle()
                    .fill(.teal)
                    .frame(width: 32, height: 32)
                Text("\(index)")
                    .font(.callout.bold())
                    .foregroundStyle(.white)
            }
        }
    }

    struct Badge: View {
        let text: String
        let imageName: String

        var body: some View {
            HStack {
                Image(systemName: imageName)
                Text(text)
            }
        }
    }
}

#Preview {
    NewsRowView(story: TestData.story, index: 1)
}
