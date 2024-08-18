//
//  ReminderCategoryDetails.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/04/20.
//

import SwiftUI

struct ReminderCategoryDetails: View {
    let reminderCategory: ReminderCategory
    
    @EnvironmentObject var localNotificationManger: LocalNotificationManager
    @Environment(\.scenePhase) var scenePhase
    @State var reminderDate: Date = .now
    
    /// All the ui below is to test our notifcation manager for when we build the reminders app and people set reminders.
    
    var body: some View {
        VStack {
            Image(systemName: reminderCategory.icon)
                .font(.largeTitle)
            Spacer()
            if localNotificationManger.isGranted {
                GroupBox {
                    Button {
                        var localNotification = LocalNotification(
                            title: "My first SwiftUI Notification",
                            body: "This is my first notification using a notification manaager.",
                            identifier: UUID().uuidString,
                            timeInterval: 10,
                            notificationRepeat: false)
                        localNotification.noficationType = .time
                        localNotificationManger.scheduleNotification(localNotification: localNotification)
                    } label: {
                        Text("Schedule Notification")
                    }
                    .buttonStyle(.borderedProminent)
                    Divider()
                    DatePicker("Pick a date for notification", selection: $reminderDate)
                        .labelsHidden()
                    Button {
                        let dateComponents = Calendar.current.dateComponents(
                            [
                                .year,
                                .month,
                                .day,
                                .hour,
                                .minute
                            ],
                            from: reminderDate
                        )
                        var localNotification = LocalNotification(
                            title: "My first SwiftUI Notification",
                            body: "This is my first notification using a notification manaager.",
                            identifier: UUID().uuidString,
                            dateComponents: dateComponents,
                            notificationRepeat: false
                        )
                        localNotification.bundleImage = "moonwalk.jpeg"
                        localNotification.userInfo = ["screen_type": ScreenType.promo.rawValue]
                        localNotification.noficationType = .calendar
                        localNotificationManger.scheduleNotification(localNotification: localNotification)
                    } label: {
                        Text("Schedule Calendar Notification")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                Button(action: {
                    localNotificationManger.openAppSettings()
                }) {
                    Text("Enable Notifications")
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .onChange(of: scenePhase, perform: { value in
            if value == .active {
                Task {
                    await localNotificationManger.getNotificationAuthStatus()
                }
            }
        })
//        .onChange(of: scenePhase) { oldValue, newValue in
//            if newValue == .active {
//                Task {
//                    await localNotificationManger.getNotificationAuthStatus()
//                }
//            }
//        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(reminderCategory.name)
    }
}

#Preview {
    ReminderCategoryDetails(
        reminderCategory: .init(
            title: "Test",
            color: ColorComponents.fromColor(.red),
            icon: "star",
            reminderCount: 5,
            listNumber: 0
        )
    )
    .environmentObject(LocalNotificationManager())
}
