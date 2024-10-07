//
//  NewReminderViewModel.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/07/14.
//

import SwiftUI

final class NewReminderViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var notes: String = ""
    @Published var reminderName = Constants.defaultReminderName
    @Published var reminder: Reminder? = nil
}
