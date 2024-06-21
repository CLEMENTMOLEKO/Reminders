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
        List {
            categories
            lists
        }
        .sheet(item: $localNotificationManager.nextView) { nextView in
            nextView
        }
        .searchable(text: .constant(""))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    //TODO: This will set the list in editing mode...
                }            }
            ToolbarItem(placement: .bottomBar) {
                insets
            }
        }
        .task {
            await localNotificationManager.requestAuthorization()
        }
    }
}

//MARK: HOMEVIEW COMPONENTS
private extension HomeView {
    private var categories: some View {
        Section {
            CategoriesView(categories: homeViewModel.reminderCategories)
        }
        .listRowInsets(.init())
        .listRowSpacing(8.0)
        .listRowBackground(Color.clear)
    }
    
    private var lists: some View {
        Section {
            ForEach(homeViewModel.reminderlists) { reminderList in
                NavigationLink(value: NavigationValues.lists(list: reminderList)){
                    MyListItem(list: reminderList)
                        .padding(1)
                        .badge(1)
                }
            }
        } header: {
            Text("My List")
                .font(.title2)
                .fontWeight(.bold)
        }
        .headerProminence(.increased)
        .listStyle(.grouped)
    }
    
    private var insets: some View {
        HStack {
            Button {
                
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("New Reminder")
                }
                .font(.headline)
            }
            Spacer()
            Button("Add List") {
                
            }
            .font(.headline)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .navigationDestination(for: NavigationValues.self, destination: { $0 })
            .environmentObject(NavigationManager())
            .environmentObject(LocalNotificationManager())
    }
}
