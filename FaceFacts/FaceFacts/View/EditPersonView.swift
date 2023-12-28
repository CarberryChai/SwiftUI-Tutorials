//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/27.
//

import SwiftUI

struct EditPersonView: View {
    @Bindable var person: Person
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)

                TextField("Email Address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
