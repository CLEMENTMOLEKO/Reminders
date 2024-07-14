//
//  NewReminderViewModel.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/07/14.
//

import SwiftUI

final class NewReminderViewModel: ObservableObject {
    @Published var title = ""
    @Published var notes = ""
    @Published var listType = "Reminder"
    
    var reminderlists = [
        ReminderList(name: "Reminder", color: Color.blue, icon: "star.fill"),
        ReminderList(name: "Test", color: Color.green, icon: "star.fill"),
        ReminderList(name: "Todos", color: Color.orange, icon: "star.fill"),
        ReminderList(name: "Other", color: Color.purple, icon: "star.fill")
    ]
}
