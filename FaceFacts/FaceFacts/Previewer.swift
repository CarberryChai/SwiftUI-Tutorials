//
//  Previewer.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/31.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let event: Event
    let person: Person

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)

        event = Event(name: "Test Event", location: "China shanghai")
        person = Person(name: "Mia", emailAddress: "mia8777@gmail.com", details:"she is a pretty girl.", metAt: event)
        container.mainContext.insert(person)
    }
}
