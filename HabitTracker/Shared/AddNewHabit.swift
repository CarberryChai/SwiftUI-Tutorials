//
//  AddNewHabit.swift
//  HabitTracker
//
//  Created by 柴长林 on 2022/5/17.
//

import SwiftUI

struct AddNewHabit: View {
  @EnvironmentObject var store: Store
  @Environment(\.self) var env
  var body: some View {
    NavigationView {
      VStack(spacing: 15) {
        TextField("Title", text: $store.title)
          .padding(.horizontal)
          .padding(.vertical, 10)
          .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.gray.opacity(0.1))
          }

        // MARK: Habit Color Picker
        HStack(spacing: 0) {
          ForEach(1...7, id: \.self) { index in
            let color = "Card-\(index)"
            Circle()
              .fill(Color(color))
              .frame(width: 30, height: 30)
              .overlay {
                if store.habitColor == color {
                  Image(systemName: "checkmark")
                    .font(.caption.bold())
                }
              }
              .onTapGesture {
                withAnimation {
                  store.habitColor = color
                }
              }
              .frame(maxWidth: .infinity)
          }
        }.padding(.vertical)

        Divider()

        // fequency selection
        VStack(alignment: .leading, spacing: 6) {
          Text("Frequency").font(.callout.bold())

          let weekDays = Calendar.current.shortWeekdaySymbols
          HStack(spacing: 10) {
            ForEach(weekDays, id: \.self) { day in
              let index = store.weekDays.firstIndex { $0 == day } ?? -1
              Text(day)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background {
                  RoundedRectangle(cornerRadius: 10, style: .continuous).fill(
                    index != -1 ? Color(store.habitColor) : Color.gray.opacity(0.1))
                }
                .onTapGesture {
                  withAnimation {
                    if index != -1 {
                      store.weekDays.remove(at: index)
                    } else {
                      store.weekDays.append(day)
                    }
                  }
                }
            }
          }.padding(.vertical, 10)
        }

        Divider().padding(.vertical, 15)

        HStack {
          VStack(alignment: .leading, spacing: 6) {
            Text("Remainder").fontWeight(.semibold)
            Text("Just notification").font(.caption).foregroundColor(.gray)
          }.frame(maxWidth: .infinity, alignment: .leading)
          Toggle(isOn: $store.isRemainderOn) {}.labelsHidden()
        }
      }
      .frame(maxHeight: .infinity, alignment: .top)
      .padding()
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Add Habit")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            env.dismiss()
          } label: {
            Image(systemName: "xmark.circle")
          }.tint(.white)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Done") {

          }.tint(.white)
        }
      }
    }.preferredColorScheme(.dark)
  }
}

struct AddNewHabit_Previews: PreviewProvider {
  static var previews: some View {
    AddNewHabit()
      .environmentObject(Store())
  }
}
