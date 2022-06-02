//
//  NewTransaction.swift
//  ExpenseTracker
//
//  Created by 柴长林 on 2022/6/1.
//

import SwiftUI

struct NewTransaction: View {
  @EnvironmentObject var store: Store
  @Binding var show: Bool

  var body: some View {
    VStack(spacing: 12) {
      Text("Add Expense")
        .font(.title2)
        .fontWeight(.semibold)
        .opacity(0.7)
      
      if let symbol = store.convertExpenseToCurrency(0).first {
        TextField("0", text: $store.amount)
          .font(.system(size: 35))
          .foregroundColor(.pink)
          .multilineTextAlignment(.center)
          .keyboardType(.numberPad)
          .background {
            Text(store.amount.isEmpty ? "0" : store.amount)
              .font(.system(size: 35))
              .opacity(0)
              .overlay(alignment: .leading) {
                Text(String(symbol))
                  .opacity(0.5)
                  .offset(x: -20, y: 5)
              }
          }
          .padding(.vertical, 10)
          .frame(maxWidth: .infinity)
          .background {
            Capsule().fill(.white)
          }
          .padding(.horizontal, 20)
      }
      
      Label {
        TextField("remark", text: $store.remark).padding(.leading, 10)
      } icon: {
        Image(systemName: "list.bullet.rectangle.portrait.fill")
          .font(.title3)
          .foregroundColor(.gray)
      }
      .padding()
      .background {
        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
      }
      .padding(.horizontal, 10)
      .padding(.top, 20)
      
      Label {
        customCheckbox.padding(.leading, 10)
      } icon: {
        Image(systemName: "arrow.up.arrow.down")
          .font(.title3)
          .foregroundColor(.gray)
      }
      .padding()
      .background {
        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
      }
      .padding(.horizontal, 10)
      .padding(.top, 20)
      
      Label {
        DatePicker.init("", selection: $store.date, in: Date.distantPast...Date(), displayedComponents: [.date])
          .datePickerStyle(.compact)
          .labelsHidden()
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 10)
      } icon: {
        Image(systemName: "calendar")
          .font(.title3)
          .foregroundColor(.gray)
      }
      .padding()
      .background {
        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.white)
      }
      .padding(.horizontal, 10)
      .padding(.top, 20)
      
      // Save Button
      
      Button {
        store.addTransaction()
        show = false
      } label: {
        Text("Save")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundColor(.white)
          .frame(maxWidth: .infinity)
          .padding()
          .background {
            RoundedRectangle(cornerRadius: 14, style: .continuous).fill( LinearGradient(colors: [.pink, .purple, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
          }
          .padding(.horizontal, 10)
          .padding(.top, 60)
      }
        .disabled(store.amount.isEmpty || store.remark.isEmpty || store.type == .all)
        .opacity(store.amount.isEmpty || store.remark.isEmpty || store.type == .all ? 0.5 : 1)

    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .background {
      Color("bgc").ignoresSafeArea()
    }
    .overlay(alignment: .topTrailing) {
      Button {
        show = false
      } label: {
        Image(systemName: "xmark")
          .font(.title3)
          .foregroundColor(.black)
      }
      .padding()
    }
  }
  
  var customCheckbox: some View {
    HStack(spacing: 10) {
      ForEach([ExpenseType.income, ExpenseType.expense], id: \.self) {type in
        ZStack {
          RoundedRectangle(cornerRadius: 2, style: .continuous).stroke(lineWidth: 2).fill(.black)
            .opacity(0.5)
            .frame(width: 20, height: 20)
          if store.type == type {
            Image(systemName: "checkmark")
              .font(.caption.bold())
              .foregroundColor(.green)
          }
        }
        .onTapGesture {
          store.type = type
        }
        Text(type.rawValue.capitalized)
          .font(.callout)
          .fontWeight(.semibold)
          .opacity(0.7)
          .padding(.trailing, 10)
      }
    }.frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct NewTransaction_Previews: PreviewProvider {
  static var previews: some View {
    NewTransaction(show: .constant(false))
      .environmentObject(Store())
  }
}
