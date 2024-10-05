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
        name: String,
        color: ColorComponents,
        icon: String,
        reminderCount: Int,
        listNumber: Int
    ) {
        self.name = name
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
    
    var id = UUID().uuidString
    var name: String
    var color: ColorComponents
    var icon: String
    var reminderCount: Int
    var listNumber: Int
}

// Can't make a @Model Decodable.
struct CodableReminderCategory: Codable {
    let id: String
    let name: String
    let color: ColorComponents
    let icon: String
    let reminderCount: Int
    let listNumber: Int
    
    func toModel() -> ReminderCategory {
        ReminderCategory(
            name: self.name,
            color: self.color,
            icon: self.icon,
            reminderCount: self.reminderCount,
            listNumber: self.listNumber
        )
    }
}
