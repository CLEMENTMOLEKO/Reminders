//
//  ListRowItem.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/23.
//

import SwiftUI

protocol ListItem {
    var name: String { get }
    var color: ColorComponents { get }
    var icon: String { get }
}

struct ListRowItem: View {
    let item: ListItem
    
    var body: some View {
        Label {
            Text(item.name)
        } icon: {
                Circle()
                    .frame(width: 35)
                    .foregroundColor(item.color.color)
                    .overlay {
                        Image(systemName: item.icon)
                            .foregroundColor(.white)
                    }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ListRowItem(item: ReminderList(name: "Reminders", color: ColorComponents.fromColor(.blue), icon: "star.fill"))
        .previewLayout(.sizeThatFits)
}
