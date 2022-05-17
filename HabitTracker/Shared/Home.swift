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
    .sheet(isPresented: $store.addNewHabit) {
      AddNewHabit()
    }
  }

  var header: some View {
    Text("Habits")
      .font(.title2.bold())
      .frame(maxWidth: .infinity)
      .overlay(alignment: .trailing) {
        Button {

        } label: {
          Image(systemName: "gearshape")
            .font(.title3)
            .foregroundColor(.white)
        }

      }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(Store())
  }
}
