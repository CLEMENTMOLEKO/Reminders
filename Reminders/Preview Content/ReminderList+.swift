//
//  DevData.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/08/18.
//

import SwiftUI

let reminderlists = [
    ReminderList(name: "Reminder", color: ColorComponents.fromColor(Color.blue), icon: "star.fill", reminders: []),
    ReminderList(name: "Test", color: ColorComponents.fromColor(Color.green), icon: "star.fill", reminders: []),
    ReminderList(name: "Todos", color: ColorComponents.fromColor(Color.orange), icon: "star.fill", reminders: []),
    ReminderList(name: "Other", color: ColorComponents.fromColor(Color.purple), icon: "star.fill", reminders: [])
]

extension ReminderList {
    static var examples: [ReminderList] { reminderlists }
}
