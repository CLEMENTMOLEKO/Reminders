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
            HomeView()
                .navigationStackWithDestination(
                    for: NavigationValues.self,
                    path: $navigationManager.navigationRoutes
                )
                .sheet(item: $localNotificationManager.notificationsView) { nextView in
                    nextView
                }
                .environmentObject(navigationManager)
                .environmentObject(localNotificationManager)
        }
    }
}
