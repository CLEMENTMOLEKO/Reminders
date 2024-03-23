//
//  ReminderCategory.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import Foundation
import SwiftUI

struct ReminderCategory: Identifiable, Hashable {
    let id = UUID().uuidString
    let title: String
    let color: Color
    let icon: String
    let reminderCount: Int
}
