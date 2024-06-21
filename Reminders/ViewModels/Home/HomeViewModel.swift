//
//  HomeViewModel.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeSearchValue: String = ""
    
    
    //MARK: Dummy Data, will delete once integrated swiftdata. or save in preview content.
    let reminderCategories = [
        ReminderCategory(
            title: "Today",
            color: Color.blue,
            icon: "calendar",
            reminderCount: 0
        ),
        ReminderCategory(
            title: "Scheduled",
            color: Color.red,
            icon: "calendar",
            reminderCount: 1
        ),
        ReminderCategory(
            title: "All",
            color: Color.gray,
            icon: "tray.fill",
            reminderCount: 0
        ),
        ReminderCategory(
            title: "Flagged",
            color: Color.indigo,
            icon: "flag",
            reminderCount: 0
        ),
        ReminderCategory(
            title: "Completed",
            color: Color.green,
            icon: "checkmark",
            reminderCount: 0
        )
    ]
   
    let reminderlists = [
        ReminderList(name: "Reminder", color: Color.blue, icon: "star.fill"),
        ReminderList(name: "Test", color: Color.green, icon: "star.fill"),
        ReminderList(name: "Todos", color: Color.orange, icon: "star.fill"),
        ReminderList(name: "Other", color: Color.purple, icon: "star.fill")
    ]
}
