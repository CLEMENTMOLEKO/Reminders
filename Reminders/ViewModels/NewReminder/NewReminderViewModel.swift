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
}
