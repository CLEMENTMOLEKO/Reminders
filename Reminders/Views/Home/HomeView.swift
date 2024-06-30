//
//  HomeView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.editMode) private var editMode
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    
    @State var selectionItems = Set<ReminderCategory.ID>()
    
    var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    let homeViewModel: HomeViewModel = .init()
    
    var body: some View {
        List(selection: $selectionItems) {
            categories
            lists
        }
        .sheet(item: $localNotificationManager.nextView) { nextView in
            nextView
        }
        .searchable(text: .constant(""))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .bottomBar) {
                BottomBar()
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
            if(isEditing){
                ForEach(homeViewModel.reminderCategories){ reminderCategory in
                    ListRowItem(item: reminderCategory)
                        .padding(1)
                }
                .onMove { indices, newOffset in
                    print("Moving \(indices), \(newOffset)")
                }
            } else {
                CategoriesView(categories: homeViewModel.reminderCategories)
            }
        }
        .listRowInsets(isEditing ? nil : .init())
        .listRowSpacing(isEditing ? nil : 8.0)
        .listRowBackground(isEditing ? nil : Color.clear)
    }
    
    private var lists: some View {
        Section {
            ForEach(homeViewModel.reminderlists) { reminderList in
                //TODO: create a view modifier to do this efficiently...
                if(!isEditing) {
                    NavigationLink(value: NavigationValues.lists(list: reminderList)){
                        ListRowItem(item: reminderList)
                            .padding(1)
                            .badge(1)
                    }
                } else {
                    ListRowItem(item: reminderList)
                            .padding(1)
                            .badge(1)
                }
            }
            .onMove{ indices, newOffset in
                print("Moved indeces: \(indices), newOffset: \(newOffset)")
            }
            .onDelete(perform: { indexSet in
                print("deleting \(indexSet.first ?? 1)")
            })
        } header: {
            Text("My List")
                .font(.title2)
                .fontWeight(.bold)
        }
        .headerProminence(.increased)
        .listStyle(.grouped)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .navigationDestination(for: NavigationValues.self, destination: { $0 })
            .environmentObject(NavigationManager())
            .environmentObject(LocalNotificationManager())
    }
    //.preferredColorScheme(.dark)
}
