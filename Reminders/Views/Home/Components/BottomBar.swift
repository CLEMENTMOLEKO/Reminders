//
//  BottomBar.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/30.
//

import SwiftUI

struct BottomBar: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @State var isNewReminderModalPresented = false
    @State var isNewListModalPresented = false
    
    var body: some View {
        HStack {
            NavigationModal(
                for: NewReminderNavigationValues.self,
                path: $navigationManager.newReminderNavigationRoutes,
                isPresented: $isNewReminderModalPresented
            ) {
                NavigationLink(value: NewReminderNavigationValues.details){
                    Text("Test New Reminder Navigation")
                }
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
                isNewListModalPresented.toggle()
            } label: {
                Text("Add List")
            }
            .sheet(isPresented: $isNewListModalPresented){
                NavigationStack {
                    NewListView()
                }
            }
        }
    }
}

#Preview {
    BottomBar()
}
