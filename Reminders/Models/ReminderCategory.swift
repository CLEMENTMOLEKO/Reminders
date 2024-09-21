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
    
    var id = UUID().uuidString
    var name: String
    var color: ColorComponents
    var icon: String
    var reminderCount: Int
    var listNumber: Int
}
