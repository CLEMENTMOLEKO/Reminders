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
    let container: ModelContainer
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
        .modelContainer(container)
    }
}

extension RemindersApp {
    init() {
        let schema = Schema([ReminderCategory.self, ReminderList.self])
        let config = ModelConfiguration("Reminders", schema: schema)
        do {
            try container = ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Error initializing the DB")
        }
        seedReminderCategories()
    }
    
    private func seedReminderCategories() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        guard !launchedBefore else { return }
        
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        reminderCategories.forEach { reminderCategory in
            container.mainContext.insert(reminderCategory)
        }
    }

}
