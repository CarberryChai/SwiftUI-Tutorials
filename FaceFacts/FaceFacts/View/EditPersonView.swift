//
//  EditPersonView.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/27.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditPersonView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var person: Person
    @Binding var path: NavigationPath
    @Query(sort: [SortDescriptor(\Event.name), SortDescriptor(\Event.location)])
    var events: [Event]
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        Form {
            Section {
                if let photo = person.photo, let uiimage = UIImage(data: photo) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Label("Select a Photo", systemImage: "person")
                }
            }

            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)

                TextField("Email Address", text: $person.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section("Where did you meet them ?") {
                Picker("Events", selection: $person.metAt) {
                    Text("Unknown Event")
                        .tag(Event?.none)

                    if !events.isEmpty {
                        Divider()
                        ForEach(events) { event in
                            Text(event.name)
                                .tag(Optional(event))
                        }
                    }
                }
                Button("create new event", action: createEvent)
            }

            Section("Notes") {
                TextField("Details about this person", text: $person.details, axis: .vertical)
            }
        }
        .navigationTitle("Edit Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Event.self) { event in
            EditEventView(event: event)
        }
        .onChange(of: selectedItem, loadPhoto)
    }

    private func createEvent() {
        let event = Event(name: "", location: "")
        modelContext.insert(event)
        path.append(event)
    }

    private func loadPhoto() {
        Task { @MainActor in
            person.photo = try await selectedItem?.loadTransferable(type: Data.self)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditPersonView(person: previewer.person, path: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("failed init the previewer: \(error.localizedDescription)")
    }
}
