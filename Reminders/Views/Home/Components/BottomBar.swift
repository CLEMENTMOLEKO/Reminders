//
//  BottomBar.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/30.
//

import SwiftUI

struct BottomBar: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @Binding var homeNavigationValue: HomeNavigationSheeValues?
    
    @State var isNewReminderModalPresented = false
    @State var isNewListModalPresented = false
    
    var body: some View {
        HStack {
            NavigationModal(
                for: NewReminderNavigationValues.self,
                path: $navigationManager.newReminderNavigationRoutes,
                isPresented: $isNewReminderModalPresented
            ) {
               NewReminderView()
            } action: {
                isNewReminderModalPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("New Reminder")
                }
                .font(.headline)
            }

            Spacer()
            
            Button {
                homeNavigationValue = .addList
            } label: {
                Text("Add List")
            }
        }
    }
}

#Preview {
    BottomBar(homeNavigationValue: .constant(.addList))
}
