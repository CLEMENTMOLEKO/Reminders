//
//  HomeNavigationSheetValues.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/07/21.
//

import SwiftUI

enum HomeNavigationSheeValues: Identifiable, Hashable, View {
    case templates
    case addList
    
    var id: Self { self }
    
    var body: some View {
        switch self {
        case .templates:
            Text("Templates")
        case .addList:
            NavigationStack {
                NewListView()
            }
        }
    }
}
