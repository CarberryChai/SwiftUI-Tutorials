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
                            // 激活目标对象可拖拽，payload是任何遵循Transferable协议的类型
                            .draggable(color) {
                                // 在拖拽中提供一个跟随的view或者icon
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 1, height: 1)
                                    .onAppear {
                                        originItem = color
                                    }
                            }
                            // 承载拖拽目标对象的view
                            .dropDestination(for: Color.self) { _, _ in
                                // drop之后调用，$0为拖拽目标对象数组[Color], $1为drop点坐标CGPoint
                                false
                            } isTargeted: { status in
                                // 拖拽目标对象进入和离开drop区域时调用，status is true when the cursor is inside the area, and
                                // false when the cursor is outside.
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
