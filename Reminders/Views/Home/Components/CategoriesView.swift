//
//  CategoriesView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/19.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [ReminderCategory]
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(minimum: 20)),
                count: 2
            ), spacing: 8.0
        ) {
            ForEach(categories) { reminderCategory in
                RemindersCategoryView(reminderCategory: reminderCategory)
                    .onTapGesture {
                        navigationManager.navigate(to: NavigationValues.category(category: reminderCategory))
                    }
            }
            .onMove{ indices, newOffset in
                print("Moved indeces: \(indices), newOffset: \(newOffset)")
            }
            .onDelete(perform: { indexSet in
                print("deleting \(indexSet.first ?? 1)")
            })
        }
    }
}

#Preview {
    CategoriesView(categories: [ReminderCategory]())
}
