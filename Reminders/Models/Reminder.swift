//
//  Reminder.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/09/01.
//

import Foundation
import SwiftData

@Model
class Reminder {
    internal init(
        title: String,
        notes: String,
        date: Date,
        time: Date,
        tags: [Tag],
        location: String,
        whenMessaging: Bool,
        flag: Bool,
        priority: Priority,
        list: ReminderList,
        subtasks: [Reminder],
        imagePath: String
    ) {
        self.title = title
        self.notes = notes
        self.date = date
        self.time = time
        self.tags = tags
        self.location = location
        self.whenMessaging = whenMessaging
        self.flag = flag
        self.priority = priority.rawValue
        self.list = list
        self.subtasks = subtasks
        self.imagePath = imagePath
    }
    
    var title: String
    var notes: String
    var date: Date
    var time: Date
    var tags: [Tag]
    var location: String //TODO: location needs revisiting, taking note of the reminders location component.
    var whenMessaging: Bool
    var flag: Bool
    var priority : Priority.RawValue
    var list: ReminderList
    var subtasks: [Reminder]
    var imagePath: String //Use file manager to save images?
    
    enum Priority: String, Hashable {
        case low, medium, high
    }
}
