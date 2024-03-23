//
//  RemindersApp.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI

@main
struct RemindersApp: App {
    @StateObject var localNotificationManager: LocalNotificationManager = .init()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(localNotificationManager)
        }
    }
}
