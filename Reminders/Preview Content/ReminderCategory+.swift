//
//  ReminderCategory+.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/09/21.
//

import Foundation

extension ReminderCategory {
    static var examples: [ReminderCategory] {
       [
            ReminderCategory(
                name: "Today",
                color: ColorComponents.fromColor(.blue),
                icon: "calendar",
                reminderCount: 0,
                listNumber: 0
            ),
            ReminderCategory(
                name: "Scheduled",
                color: ColorComponents.fromColor(.red),
                icon: "calendar",
                reminderCount: 0,
                listNumber: 1
            ),
            ReminderCategory(
                name: "All",
                color: ColorComponents.fromColor(.gray),
                icon: "tray.fill",
                reminderCount: 0,
                listNumber: 2
            ),
            ReminderCategory(
                name: "Flagged",
                color: ColorComponents.fromColor(.indigo),
                icon: "flag",
                reminderCount: 0,
                listNumber: 3
            ),
            ReminderCategory(
                name: "Completed",
                color: ColorComponents.fromColor(.green),
                icon: "checkmark",
                reminderCount: 0,
                listNumber: 4
            )
       ]
    }
}
