//
//  ContentView.swift
//  MovableGrid
//
//  Created by changlin on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var toggleGrid = false
    @State private var colors: [Color] = [.gray, .yellow, .green, .blue, .purple, .indigo, .pink, .brown, .cyan,
                                          .orange, .mint, .teal]
    @State private var originItem: Color?
    var body: some View {
        NavigationStack {
            ScrollView {
                let columns = Array(repeating: GridItem(spacing: 10), count: toggleGrid ? 2 : 3)
                LazyVGrid(columns: columns) {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(color.gradient)
                            .frame(height: 100)
                            .draggable(color) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 1, height: 1)
                                    .onAppear {
                                        originItem = color
                                    }
                            }
                            .dropDestination(for: Color.self) { _, _ in
                                false
                            } isTargeted: { status in
                                if status, let originItem, originItem != color {
                                    if let originIdx = colors.firstIndex(of: originItem),
                                       let destinationIdx = colors.firstIndex(of: color) {
                                        withAnimation(.bouncy) {
                                            let source = colors.remove(at: originIdx)
                                            colors.insert(source, at: destinationIdx)
                                        }
                                    }
                                }
                            }
                    }
                }
            }
            .padding()
            .navigationTitle("Movable Grid")
            .toolbar {
                Button {
                    withAnimation {
                        toggleGrid.toggle()
                    }
                } label: {
                    Image(systemName: "rectangle.grid.\(toggleGrid ? 3 : 2)x2")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
