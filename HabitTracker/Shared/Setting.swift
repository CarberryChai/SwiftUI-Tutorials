//
//  Setting.swift
//  HabitTracker
//
//  Created by 柴长林 on 2022/5/19.
//

import SwiftUI

struct Setting: View {
  @EnvironmentObject var store: Store

  var body: some View {
    NavigationView {
      List {
        Section("Setting") {
          Toggle(isOn: $store.isColorSchemeDark) {
            Image(systemName: store.isColorSchemeDark ? "sun.max" : "moon.stars.fill")
          }
        }
      }
      .navigationTitle("Setting")
      .navigationViewStyle(.stack)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            store.showSetting.toggle()
          } label: {
            Image(systemName: "xmark.circle")
          }
        }
      }
    }
    .preferredColorScheme(store.isColorSchemeDark ? .dark : .light)
  }
}

struct Setting_Previews: PreviewProvider {
  static var previews: some View {
    Setting()
  }
}
