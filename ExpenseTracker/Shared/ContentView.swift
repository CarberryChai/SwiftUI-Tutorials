//
//  ContentView.swift
//  Shared
//
//  Created by 柴长林 on 2022/5/21.
//

import CoreData
import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      Home()
        .navigationBarHidden(true)
    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(Store())
  }
}
