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
  @Published var expenses: [Expense] = []
  @Published var startDate: Date = Date()
  @Published var endDate: Date = Date()
  @Published var currentMonthStartDate: Date = Date()
  
  var totalSum: Double {
    expenses.reduce(0, {$0 + ($1.type == "income" ? $1.amount : -$1.amount)})
  }
  var totalIncome: Double {
    expenses.filter({$0.type == "income"}).reduce(0, {$0 + $1.amount})
  }
  var totalExpense: Double {
    totalSum - totalIncome
  }

  // MARK: Expense
  @Published var amount: Double = 0
  @Published var remark: String = ""
  @Published var type: ExpenseType = .income
  
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
      expenses =  try container.viewContext.fetch(request)
    } catch {
      print("load data error: \(error.localizedDescription)")
    }
  }
  var currentMonthRangeString: String {
    currentMonthStartDate.formatted(date: .abbreviated, time: .omitted) + " - "
    + Date().formatted(date: .abbreviated, time: .omitted)
  }

  func addTransaction() {
    let transaction = Expense(context: container.viewContext)
    transaction.amount = amount
    transaction.id = UUID().uuidString
    transaction.type = type.rawValue
    transaction.remark = remark
    transaction.date = Date()
    transaction.color = "c-1"
    save()
  }

  func convertExpenseToCurrency(_ amount: Double) -> String {
    let formater = NumberFormatter()
    formater.numberStyle = .currency
    return formater.string(from: .init(value: amount)) ?? "$0:00"
  }
  
  private func save() {
    do {
      try container.viewContext.save()
      loadData()
    } catch  {
      print("failed save data. \(error.localizedDescription)")
    }
  }
}

enum ExpenseType: String {
  case income
  case expense
  case all
}
