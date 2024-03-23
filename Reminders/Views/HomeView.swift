//
//  HomeView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    let homeViewModel: HomeViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                categories
                lists
                Spacer()
            }
            .sheet(item: $localNotificationManager.nextView, content: { nextView in
                nextView.view()
            })
            .searchable(text: .constant(""))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        //TODO: this is actually a menu...
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .navigationDestination(for: ReminderCategory.self) { reminderCategory in
                ReminderCategoryDetails(reminderCategory: reminderCategory)
            }
        }
        .task {
            await localNotificationManager.requestAuthorization()
        }
    }
}

private extension HomeView {
    private var categories: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30)), count: 2)) {
            ForEach(homeViewModel.reminderCategories) { reminderCategory in
                NavigationLink(value: reminderCategory){
                    RemindersCategoryView(reminderCategory: reminderCategory)
                }
            }
        }
        .padding()
    }
    
    private var lists: some View {
        List{
            Section {
                ForEach(1..<5) { _ in
                    Text("Test")
                }
            } header: {
                Text("My List")
                    .fontWeight(.bold)
            }
            .headerProminence(.increased)
        }
    }
}

#Preview {
    HomeView()
}
