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
                Button {
                    //TODO: this is actually a menu...
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
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
            ForEach(1..<5) { _ in
                Text("Test")
            }
        } header: {
            Text("My List")
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
