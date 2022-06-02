//
//  Store.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/5/21.
//

import CoreData
import SwiftUI

@MainActor
class Store: ObservableObject {
  static private let colors = Array(1...5).map { "c-\($0)" }
  @Published var expenses: [Expense] = []
  @Published var startDate: Date = Date()
  @Published var endDate: Date = Date()
  @Published var currentMonthStartDate: Date = Date()
  
  @Published var edittingItem: Expense?
  
  var totalSum: Double {
    expenses.reduce(0, { $0 + ($1.type == "income" ? $1.amount : -$1.amount) })
  }
  var totalIncome: Double {
    expenses.filter({ $0.type == "income" }).reduce(0, { $0 + $1.amount })
  }
  var totalExpense: Double {
    totalSum - totalIncome
  }

  // MARK: Expense
  @Published var amount: String = ""
  @Published var remark: String = ""
  @Published var type: ExpenseType = .all
  @Published var date: Date = .init()

  lazy var container: NSPersistentContainer = {
    let result = NSPersistentContainer(name: "ExpenseTracker")
    result.loadPersistentStores { desc, err in
      if let err = err {
        fatalError("can't load core data \(err.localizedDescription)")
      }
    }
    return result
  }()

  init() {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: Date())
    startDate = calendar.date(from: components)!
    currentMonthStartDate = calendar.date(from: components)!

    loadData()
  }
  private func loadData() {
    let request = NSFetchRequest<Expense>(entityName: "Expense")
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]
    do {
      expenses = try container.viewContext.fetch(request)
    } catch {
      print("load data error: \(error.localizedDescription)")
    }
  }
  var currentMonthRangeString: String {
    currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - "
      + Date().formatted(date: .abbreviated, time: .omitted)
  }
  var rangeString: String {
    startDate.formatted(date: .abbreviated, time: .omitted) + " - "
      + Date().formatted(date: .abbreviated, time: .omitted)
  }

  func addTransaction() {
    let transaction = Expense(context: container.viewContext)
    transaction.amount = (amount as NSString).doubleValue
    transaction.id = UUID().uuidString
    transaction.type = type.rawValue
    transaction.remark = remark
    transaction.date = date
    transaction.color = Store.colors.randomElement()
    save()
  }
  
  func restoreTransaction() {
    if let edittingItem = edittingItem {
      amount = String(edittingItem.amount)
      remark = edittingItem.remark ?? ""
      type = ExpenseType(rawValue: edittingItem.type ?? "all") ?? .all
      date = edittingItem.date ?? Date()
    }
  }

  func convertExpenseToCurrency(_ amount: Double) -> String {
    let formater = NumberFormatter()
    formater.numberStyle = .currency
    return formater.string(from: .init(value: amount)) ?? "$0:00"
  }

  func resetData() {
    amount = ""
    remark = ""
    type = .all
  }

  private func save() {
    do {
      try container.viewContext.save()
      loadData()
    } catch {
      print("failed save data. \(error.localizedDescription)")
    }
  }
}

enum ExpenseType: String {
  case income
  case expense
  case all
}
