//
//  Position.swift
//  HackerNews
//
//  Created by changlin on 2023/9/3.
//

import SwiftUI

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

#Preview {
    Position(index: 1)
}
