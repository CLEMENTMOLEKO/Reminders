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
                    .fill(reminderCategory.color)
                    .frame(width: 30)
                    .overlay {
                        Image(systemName: reminderCategory.icon)
                            .foregroundColor(.white)
                    }
                Spacer()
                Text("\(reminderCategory.reminderCount)")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            Text(reminderCategory.title)
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    RemindersCategoryView(reminderCategory: ReminderCategory(title: "test", color: Color.red, icon: "plus", reminderCount: 30))
}
