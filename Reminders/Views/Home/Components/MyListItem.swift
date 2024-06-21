//
//  MyListItem.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/21.
//

import SwiftUI

struct MyListItem: View {
    let list: ReminderList
    
    var body: some View {
        Label {
            Text(list.name)
        } icon: {
                Circle()
                    .frame(width: 35)
                    .foregroundColor(list.color)
                    .overlay {
                        Image(systemName: list.icon)
                            .foregroundColor(.white)
                    }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MyListItem(list: ReminderList(name: "Reminders", color: .blue, icon: "star.fill"))
        .previewLayout(.sizeThatFits)
}
