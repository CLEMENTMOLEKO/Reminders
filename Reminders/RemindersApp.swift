//
//  RemindersApp.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI
import SwiftData

@main
struct RemindersApp: App {
    @StateObject var navigationManager: NavigationManager = .init()
    @StateObject var localNotificationManager: LocalNotificationManager = .init()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.navigationRoutes) {
                HomeView()
                    .navigationDestination(for: NavigationValues.self) { $0 }
            }
            .environmentObject(navigationManager)
            .environmentObject(localNotificationManager)
        }
    }
}
