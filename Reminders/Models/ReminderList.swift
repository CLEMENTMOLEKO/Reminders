//
//  ReminderList.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/17.
//

import SwiftUI
import SwiftData

@Model
class ReminderList : Hashable, Identifiable, ListItem {
    var id = UUID()
    var name: String
    var color: ColorComponents
    var icon: String
    @Relationship(deleteRule: .cascade, inverse: \Reminder.list)
    var reminders: [Reminder]
    
    internal init(name: String, color: ColorComponents, icon: String, reminders: [Reminder]) {
        self.name = name
        self.color = color
        self.icon = icon
        self.reminders = reminders
    }
    
    static func == (lhs: ReminderList, rhs: ReminderList) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
