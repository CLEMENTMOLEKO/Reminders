//
//  NewReminderNavigationValues.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/30.
//

import SwiftUI

enum NewReminderNavigationValues: View, Hashable, Identifiable {
    case details
    //case listType
    
    var id: Self { self }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: NewReminderNavigationValues, rhs: NewReminderNavigationValues) -> Bool {
        switch (lhs, rhs) {
        case (.details, .details):
            return true
//        case (.listType, .listType)
//            return true
//        default:
//            return false
        }
    }
    
    var body: some View {
        switch self {
        case .details:
            NewReminderDetails()
//        case .listType:
//            Text("List Type")
        }
    }
}

