//
//  Home.swift
//  PomodoroTimer
//
//  Created by 柴长林 on 2022/5/14.
//

import SwiftUI

struct Home: View {
  @EnvironmentObject var store: Store

  var body: some View {
    VStack {
      Text("Pomodoro Timer")
        .font(.title2.bold())

      GeometryReader { proxy in
        VStack(spacing: 15) {
          ZStack {
            Circle()
              .fill(.white.opacity(0.03))
              .padding(-30)

            Circle()
              .trim(from: 0, to: store.progress)
              .stroke(.white.opacity(0.03), lineWidth: 60)

            Circle()
              .stroke(Color.indigo, lineWidth: 5)
              .blur(radius: 15)
              .padding(-2)

            Circle()
              .fill(Color("BG"))

            Circle()
              .trim(from: 0, to: store.progress)
              .stroke(Color.indigo.opacity(0.7), lineWidth: 10)

            GeometryReader { proxy in
              let size = proxy.size

              Circle()
                .fill(Color.indigo.opacity(0.7))
                .frame(width: 30, height: 30)
                .overlay(Circle().fill(.white).padding(5))
                .frame(width: size.width, height: size.height, alignment: .center)
                .offset(x: size.height / 2)
                .rotationEffect(.degrees(store.progress * 360))
            }

            Text(store.timerString)
              .font(.system(size: 45, weight: .light))
              .rotationEffect(.degrees(90))
              .animation(.none, value: store.progress)
          }
          .padding(60)
          .frame(height: proxy.size.width)
          .rotationEffect(.init(degrees: -90))
          .animation(.easeInOut, value: store.progress)

          Button {

          } label: {
            Image(systemName: !store.isStarted ? "timer" : "pause")
              .font(.largeTitle.bold())
              .foregroundColor(.white)
              .frame(width: 80, height: 80)
              .background {
                Circle().fill(Color.indigo)
              }
              .shadow(color: .indigo, radius: 8, x: 0, y: 0)
          }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      }
    }
    .background {
      Color("BG")
        .ignoresSafeArea()
    }
    .padding()
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Store())
  }
}
