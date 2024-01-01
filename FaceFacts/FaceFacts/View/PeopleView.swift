//
//  PeopleView.swift
//  FaceFacts
//
//  Created by changlin on 2023/12/30.
//

import SwiftData
import SwiftUI

struct PeopleView: View {
    @Query var people: [Person]
    @Environment(\.modelContext) private var modelContext

    init(search: String = "", sortOrder: [SortDescriptor<Person>] = []) {
        _people = Query(filter: #Predicate { person in
            if search.isEmpty {
                return true
            } else {
                return person.name.localizedStandardContains(search)
                    || person.emailAddress.localizedStandardContains(search)
                    || person.details.localizedStandardContains(search)
            }
        }, sort: sortOrder)
    }

    var body: some View {
        if people.isEmpty {
            ContentUnavailableView("No People", systemImage: "person.3")
        } else {
            List {
                ForEach(people) { person in
                    NavigationLink(value: person) {
                        Text(person.name)
                    }
                }
                .onDelete(perform: deletePeople)
            }
        }
    }

    private func deletePeople(at offsets: IndexSet) {
        for offset in offsets {
            let person = people[offset]
            modelContext.delete(person)
        }
    }
}

#Preview {
    ContentView()
}
