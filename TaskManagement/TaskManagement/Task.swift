//
//  Task.swift
//  TaskManagement
//
//  Created by changlin on 8/08/23.
//

import Foundation
import SwiftData

@Model
class Task {
    @Attribute(.unique) var id: String
    var content: String
    var createdAt: Date
    var isCompleted: Bool

    init(content: String, createdAt: Date = .now, isCompleted: Bool = false) {
        self.id = UUID().uuidString
        self.content = content
        self.createdAt = createdAt
        self.isCompleted = isCompleted
    }
}
