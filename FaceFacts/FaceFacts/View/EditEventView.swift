//
//  EditEventView.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/31.
//

import SwiftUI

struct EditEventView: View {
    @Bindable var event: Event
    var body: some View {
        Form {
            TextField("Edit the event", text: $event.name)
            TextField("Edit the location", text: $event.location)
        }
        .navigationTitle("Edit Event")
        .navigationBarTitleDisplayMode(.inline)
    }
}
