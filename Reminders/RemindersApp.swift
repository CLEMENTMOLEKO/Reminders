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
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Error initializing the DB")
        }
        seedReminderCategories()
    }
    
    private func seedReminderCategories() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        guard !launchedBefore else { return }
        
        UserDefaults.standard.set(true, forKey: "launchedBefore")
        
        getSeedCategories().forEach { reminderCategory in
            container.mainContext.insert(reminderCategory)
        }
        seedReminderList()
    }
    
    private func getSeedCategories() -> [ReminderCategory] {
        guard let url = Bundle.main.url(forResource: "SeedCategories", withExtension: "json") else {
            fatalError("SeedCategories JSON file not found")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("SeedCategories JSON file could not be read")
        }
        
        do {
            let decoder = JSONDecoder()
            let codableReminderCategories = try decoder.decode([CodableReminderCategory].self, from: data)
            return codableReminderCategories.map { $0.toModel()};
        } catch {
            fatalError("Error decoding SeedCategories JSON file: \(error)")
        }
    }

    private func seedReminderList() {
        container.mainContext.insert(
            ReminderList(
                name: "Reminder",
                color: ColorComponents.fromColor(Color.blue),
                icon: "list.bullet",
                reminders: []
            )
        )
    }
}
