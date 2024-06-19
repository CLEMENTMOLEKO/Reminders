//
//  NavigationValues.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/17.
//

import SwiftUI

enum NavigationValues : Hashable, View {
    case category(category: ReminderCategory)
    case lists(list: ReminderList)
    
    var body: some View {
        switch self {
        case .category(let category):
            //TODO: category should be a protocol since different categories will have different screens.
            Text(category.title)
        case .lists(let list):
            Text(list.name)
        }
    }
}
