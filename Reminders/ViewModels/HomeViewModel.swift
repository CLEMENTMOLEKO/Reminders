//
//  HomeViewModel.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import Foundation
import CoreData
import SwiftUI

class HomeViewModel: ObservableObject {
    let remindersContainer: NSPersistentContainer
    
    @Published var reminderCategories: [ReminderCategory] = [
        ReminderCategory(title: "Today", color: Color.blue, icon: "calendar", reminderCount: 0),
        ReminderCategory(title: "Scheduled", color: Color.red, icon: "calendar", reminderCount: 1),
        ReminderCategory(title: "All", color: Color.gray, icon: "tray.fill", reminderCount: 0),
        ReminderCategory(title: "Flagged", color: Color.indigo, icon: "flag", reminderCount: 0),
        ReminderCategory(title: "Completed", color: Color.green, icon: "checkmark", reminderCount: 0)
    ]
    @Published var homeSearchValue: String = ""
    
    
    init() {
        remindersContainer = NSPersistentContainer(name: "RemindersContainer")
        remindersContainer.loadPersistentStores { description, error in
            if let error = error {
                print(error)
            }
        }
    }
}
