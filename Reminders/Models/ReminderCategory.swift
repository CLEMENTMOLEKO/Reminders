//
//  ReminderCategory.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI

class ReminderCategory: Identifiable, Hashable, ListItem {
    internal init(
        title: String,
        color: Color,
        icon: String,
        reminderCount: Int
    ) {
        self.name = title
        self.color = color
        self.icon = icon
        self.reminderCount = reminderCount
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
    let color: Color
    let icon: String
    let reminderCount: Int
}
