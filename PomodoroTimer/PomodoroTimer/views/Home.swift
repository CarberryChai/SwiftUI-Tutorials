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
            withAnimation {
              store.addNew = true
            }
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
    .overlay {
      ZStack(alignment: .bottom) {
        Color.black.opacity(store.addNew ? 0.25 : 0)
          .onTapGesture {
            store.addNew = false
          }
        newTimerView()
          .offset(y: store.addNew ? 0 : 250)
      }
    }
    .background {
      Color("BG")
        .ignoresSafeArea()
    }
    .padding()
  }

  @ViewBuilder
  func newTimerView() -> some View {
    VStack(spacing: 15) {
      Text("Add New Timer")
        .font(.title2.bold())
        .padding(.top, 10)

      HStack(spacing: 15) {
        timerText("\(store.hour) hr")
          .contextMenu {
            ContextMenuOptions(maxVal: 12, hint: "hr") { val in
              store.hour = val
            }
          }
        timerText("\(store.minute) min")
          .contextMenu {
            ContextMenuOptions(maxVal: 60, hint: "min") { val in
              store.minute = val
            }
          }
        timerText("\(store.second) sec")
          .contextMenu {
            ContextMenuOptions(maxVal: 60, hint: "sec") { val in
              store.second = val
            }
          }
      }

      Button {

      } label: {
        Text("Save")
          .font(.title3)
          .fontWeight(.semibold)
          .foregroundColor(.white)
          .padding(.horizontal, 100)
          .padding(.vertical, 15)
          .background {
            Capsule().fill(Color.indigo)
          }
      }
      .disabled(store.second == 0)
      .opacity(store.second == 0 ? 0.5 : 1)
      .padding(.top, 15)

    }
    .padding()
    .frame(maxWidth: .infinity)
    .background {
      RoundedRectangle(cornerRadius: 15, style: .continuous)
        .fill(Color("BG"))
        .ignoresSafeArea()
    }
  }

  func timerText(_ val: String) -> some View {
    Text(val)
      .font(.title3)
      .fontWeight(.semibold)
      .foregroundColor(.white.opacity(0.3))
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .background {
        Capsule().fill(.white.opacity(0.07))
      }
  }

  @ViewBuilder
  func ContextMenuOptions(maxVal: Int, hint: String, onClick: @escaping (Int) -> Void) -> some View {
    ForEach(0...maxVal, id: \.self) { value in
      Button {
        onClick(value)
      } label: {
        Text("\(value) \(hint)")
      }
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(Store())
  }
}
