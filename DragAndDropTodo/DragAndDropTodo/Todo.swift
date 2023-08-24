//
//  Todo.swift
//  DragAndDropTodo
//
//  Created by changlin on 2023/8/24.
//
import CoreTransferable
import Foundation
import UniformTypeIdentifiers

struct Todo: Identifiable, Codable, Hashable {
    let id: UUID
    var content: String
}

extension Todo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .todo)
        ProxyRepresentation(exporting: \.content)
    }

    static let mockData: [Todo] = [
        .init(id: .init(), content: "Learning English"),
        .init(id: .init(), content: "Do some homework"),
        .init(id: .init(), content: "Write code")
    ]
}

extension UTType {
    static var todo: UTType {
        .init(exportedAs: "com.carberrychai.todo")
    }
}
