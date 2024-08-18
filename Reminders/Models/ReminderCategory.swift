//
//  ReminderCategory.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI
import SwiftData

@Model
class ReminderCategory: Identifiable, Hashable, ListItem {
    internal init(
        title: String,
        color: ColorComponents,
        icon: String,
        reminderCount: Int,
        listNumber: Int
    ) {
        self.name = title
        self.color = color
        self.icon = icon
        self.reminderCount = reminderCount
        self.listNumber = listNumber
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(icon)
    }
    
    static func == (lhs: ReminderCategory, rhs: ReminderCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID().uuidString
    let name: String
    let color: ColorComponents
    let icon: String
    let reminderCount: Int
    let listNumber: Int
    
    
}

let reminderCategories = [
    ReminderCategory(
        title: "Today",
        color: ColorComponents.fromColor(Color.blue),
        icon: "calendar",
        reminderCount: 0,
        listNumber: 0
    ),
    ReminderCategory(
        title: "Scheduled",
        color: ColorComponents.fromColor(Color.red),
        icon: "calendar",
        reminderCount: 0,
        listNumber: 1
    ),
    ReminderCategory(
        title: "All",
        color: ColorComponents.fromColor(Color.gray),
        icon: "tray.fill",
        reminderCount: 0,
        listNumber: 2
    ),
    ReminderCategory(
        title: "Flagged",
        color: ColorComponents.fromColor(Color.indigo),
        icon: "flag",
        reminderCount: 0,
        listNumber: 3
    ),
    ReminderCategory(
        title: "Completed",
        color: ColorComponents.fromColor(Color.green),
        icon: "checkmark",
        reminderCount: 0,
        listNumber: 4
    )
]
