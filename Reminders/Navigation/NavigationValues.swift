//
//  NavigationValues.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/17.
//

import SwiftUI

enum NavigationValues : Hashable, View, Identifiable {
    case category(category: ReminderCategory)
    case lists(list: ReminderList)
    
    var id: Self { self }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: NavigationValues, rhs: NavigationValues) -> Bool {
        switch (lhs, rhs) {
        case (.category(let lhsCategory), .category(let rhsCategory)):
            return lhsCategory.id == rhsCategory.id
        case (.lists(let lhsList), .lists(let rhsList)):
            return lhsList.id == rhsList.id
        default:
            return false
        }
    }
    
    var body: some View {
        switch self {
        case .category(let category):
            //TODO: category should be a protocol since different categories will have different screens.
            Text(category.name)
        case .lists(let list):
            Text(list.name)
        }
    }
}
