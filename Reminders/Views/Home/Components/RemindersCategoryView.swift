//
//  RemindersCategoryView.swift
//  Reminders
//
//  RemindersCategoryView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI

struct RemindersCategoryView: View {
    let reminderCategory: ReminderCategory
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(reminderCategory.color.color)
                    .frame(width: 35)
                    .overlay {
                        Image(systemName: reminderCategory.icon)
                            .foregroundColor(.white)
                    }
                Spacer()
                Text("\(reminderCategory.reminderCount)")
                    .foregroundStyle(Color.primary)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            Text(reminderCategory.name)
                .font(.headline)
                .fontWeight(.bold)
        }
        .foregroundColor(.gray)
        .padding()
        .background(
            Color(uiColor: .tertiarySystemBackground),
            in: RoundedRectangle(cornerRadius: 10)
        )
    }
}

#Preview {
    RemindersCategoryView(
        reminderCategory: ReminderCategory(
            name: "test",
            color: ColorComponents.fromColor(.red),
            icon: "plus",
            reminderCount: 30,
            listNumber: 0
        )
    )
}
