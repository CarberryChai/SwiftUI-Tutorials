//
//  Event.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/30.
//

import Foundation
import SwiftData

@Model
class Event {
    var name: String
    var location: String
    var people: [Person] = []

    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
