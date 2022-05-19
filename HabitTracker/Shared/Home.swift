//
//  Home.swift
//  HabitTracker
//
//  Created by 柴长林 on 2022/5/17.
//

import SwiftUI

struct Home: View {
  @FetchRequest(
    entity: Habit.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Habit.dateAdded, ascending: false)],
    predicate: nil, animation: .easeInOut)
  var habits: FetchedResults<Habit>
  @EnvironmentObject var store: Store

  var body: some View {
    VStack(spacing: 0) {
      header
      ScrollView(habits.isEmpty ? .init() : .vertical, showsIndicators: false) {
        ForEach(habits) { HabitView(habit: $0) }

        VStack(spacing: 15) {
          Button {
            store.addNewHabit.toggle()
          } label: {
            Label {
              Text("New Habit")
            } icon: {
              Image(systemName: "plus.circle")
            }
            .font(.callout)
            .foregroundColor(.white)
          }
          .padding(.top, 15)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

        }.padding(.vertical)
      }
    }
    .frame(maxHeight: .infinity, alignment: .top)
    .padding()
    .sheet(
      isPresented: $store.addNewHabit,
      onDismiss: {
        store.resetData()
      }
    ) {
      AddNewHabit()
    }
    .sheet(isPresented: $store.showSetting) {
      Setting()
    }
  }

  var header: some View {
    Text("Habits")
      .font(.title2.bold())
      .frame(maxWidth: .infinity)
      .overlay(alignment: .trailing) {
        Button {
          store.showSetting.toggle()
        } label: {
          Image(systemName: "gearshape")
            .font(.title3)
           // .foregroundColor(store.curcolorScheme == .dark ? .white : .accentColor)
        }
      }
      .padding(.bottom, 10)
  }

  @ViewBuilder
  func HabitView(habit: Habit) -> some View {
    VStack(spacing: 6) {
      HStack {
        Text(habit.title ?? "")
          .font(.callout)
          .fontWeight(.semibold)
          .lineLimit(1)

        Image(systemName: "bell.badge.fill")
          .font(.callout)
          .foregroundColor(Color(habit.color ?? "Card-1"))
          .scaleEffect(0.9)
          .opacity(habit.isRemainderOn ? 1 : 0)

        Spacer()

        let count = habit.weekDays?.count ?? 0
        Text(count == 7 ? "EveryDay" : "\(count) times a week")
          .font(.caption)
          .foregroundColor(.gray)
      }.padding(.horizontal, 10)

      let calendar = Calendar.current
      let currentWeek = calendar.dateInterval(of: .weekday, for: Date())
      let symbols = calendar.shortWeekdaySymbols
      let startDate = currentWeek?.start ?? Date()
      let activeWeekDays = habit.weekDays ?? []
      //      let activePlot = symbols.indices.compactMap {index -> (String, Date) in
      //        let current = calendar.date(byAdding: .day, value: index, to: startDate)
      //        return (symbols[index], current!)
      //      }

      HStack(spacing: 0) {
        ForEach(symbols.indices, id: \.self) { index in
          let day = symbols[index]
          let curDay = calendar.date(byAdding: .day, value: index, to: startDate)

          VStack(spacing: 6) {
            Text(day)
              .font(.caption)
              .foregroundColor(.gray)

            let status = activeWeekDays.contains(where: { $0 == day })
            Text(getDate(date: curDay))
              .font(.system(size: 14))
              .fontWeight(.semibold)
              .padding(8)
              .background {
                Circle().fill(Color(habit.color ?? "Card-1"))
                  .opacity(status ? 1 : 0)
              }
          }.frame(maxWidth: .infinity)
        }
      }.padding(.top, 15)
    }
    .padding(.vertical)
    .padding(.horizontal, 6)
    .background {
      RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color.gray.opacity(0.1))
    }
    .onTapGesture {
      store.edittingHabit = habit
      store.restoreEditData()
      store.addNewHabit.toggle()
    }
  }
  private func getDate(date: Date?) -> String {
    if let date = date {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd"
      return formatter.string(from: date)
    }
    return ""
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(Store())
  }
}
