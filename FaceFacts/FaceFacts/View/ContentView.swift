//
//  ContentView.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/27.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var path = NavigationPath()
    @State private var searchText = ""
    @State private var sortOrder = [SortDescriptor(\Person.name)]

    var body: some View {
        NavigationStack(path: $path) {
           PeopleView(search: searchText, sortOrder: sortOrder)
            .navigationTitle("Face Facts")
            .navigationDestination(for: Person.self) { person in
                EditPersonView(person: person, path: $path)
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name (A-Z)")
                            .tag([SortDescriptor(\Person.name)])

                        Text("Name (Z-A)")
                            .tag([SortDescriptor(\Person.name, order: .reverse)])
                    }
                }

                Button("Add Person", systemImage: "plus", action: addPerson)
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                //print(searchText)
            }
        }
    }

    private func addPerson() {
        let person = Person(name: "", emailAddress: "", details: "")
        modelContext.insert(person)
        path.append(person)
    }
}

#Preview {
    ContentView()
}
