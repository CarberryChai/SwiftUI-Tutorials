//
//  PersistantProvider.swift
//  ExpenseTracker3
//
//  Created by changlin on 2023/9/18.
//
import CoreData
import Foundation
import SwiftUI

final class PersistantProvider {
  let persistantContainer: NSPersistentContainer

  init() {
    persistantContainer = NSPersistentContainer(name: "expenseTracker")
    persistantContainer.loadPersistentStores { _, error in
      if let error {
        fatalError("Core data store failed to load with error: \(error.localizedDescription)")
      }
    }
  }
}

extension PersistantProvider {
  func saveCategory(_ name: String) {
    let category = Category(context: persistantContainer.viewContext)
    category.name = name

    do {
      try persistantContainer.viewContext.save()
    } catch {
      persistantContainer.viewContext.rollback()
      print("Failed to save category: \(error)")
    }
  }

  func deleteCategory(_ item: Category) {
    persistantContainer.viewContext.delete(item)

    do {
      try persistantContainer.viewContext.save()
    } catch {
      persistantContainer.viewContext.rollback()
      print("Failed to delete a category: \(error)")
    }
  }

  func fetchPage<T: NSManagedObject>(_ pageIndex: Int, pageSize: Int, for request: NSFetchRequest<T>,
                                     using context: NSManagedObjectContext) throws -> [T] {
    request.fetchLimit = pageSize
    request.fetchOffset = pageIndex * pageSize
    return try context.fetch(request)
  }
}



struct PersistantKey: EnvironmentKey {
  static var defaultValue: PersistantProvider = .init()
}

extension EnvironmentValues {
  var persistentProvider: PersistantProvider {
    get { self[PersistantKey.self]}
    set { self[PersistantKey.self] = newValue }
  }
}
