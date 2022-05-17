//
//  Store.swift
//  PomodoroTimer
//
//  Created by 柴长林 on 2022/5/14.
//

import SwiftUI

class Store: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
  @Published var progress: CGFloat = 1
  @Published var isStarted = false
  @Published var addNew = false

  @Published var timerString = "00:00"
  @Published var hour: Int = 0
  @Published var minute: Int = 0
  @Published var second: Int = 0

  @Published var totalSeconds: Int = 0
  @Published var staticTotalSeconds: Int = 0

  @Published var isFinished = false
  
  override init() {
    super.init()
    authorizeNotification()
  }

  func authorizeNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { _, _ in

    }
    UNUserNotificationCenter.current().delegate = self
  }

  func userNotificationCenter(
    _ center: UNUserNotificationCenter, willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.sound, .banner])
  }

  func startTimer() {
    withAnimation(.easeInOut(duration: 0.25)) { isStarted = true }
    timerString =
      "\(hour == 0 ? "": "\(hour):")\(minute >= 10 ? "\(minute)" : "0\(minute):")\(second >= 10 ? "\(second)" : "0\(second)")"
    totalSeconds = hour * 60 * 60 + minute * 60 + second
    staticTotalSeconds = totalSeconds
    addNew = false
    addNotification()
  }

  func stopTimer() {
    withAnimation {
      isStarted = false
      hour = 0
      minute = 0
      second = 0
      progress = 1
    }
    totalSeconds = 0
    staticTotalSeconds = 0
    timerString = "00:00"
  }
  
  func reset(){
    isStarted = false
    hour = 0
    minute = 0
    second = 0
    totalSeconds = 0
    isFinished = false
    progress = 1
    staticTotalSeconds = 0
    timerString = "00:00"
  }
  
  func updateTimer() {
    totalSeconds = max(totalSeconds - 1, 0)
    progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
    hour = totalSeconds / 3600
    minute = (totalSeconds / 60) % 60
    second = totalSeconds % 60
    timerString =
      "\(hour == 0 ? "": "\(hour):")\(minute >= 10 ? "\(minute)" : "0\(minute):")\(second >= 10 ? "\(second)" : "0\(second)")"
    if hour == 0 && minute == 0 && second == 0 {
      isStarted = false
      isFinished = true
    }
  }

  func addNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Pomodoro Timer"
    content.body = "Congratulations! You did it hooray 🥳🥳🥳"
    content.sound = UNNotificationSound.default

    let request = UNNotificationRequest(
      identifier: UUID().uuidString, content: content,
      trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false))

    UNUserNotificationCenter.current().add(request)
  }
}
