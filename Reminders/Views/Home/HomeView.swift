//
//  HomeView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.editMode) private var editMode
    @EnvironmentObject var localNotificationManager: LocalNotificationManager
    @Query(sort: \ReminderCategory.listNumber) private var reminderCategories: [ReminderCategory]
    @Query(sort: \ReminderList.name) private var reminderLists: [ReminderList]
    @Query() private var tags: [Tag]
    @StateObject var homeViewModel: HomeViewModel = .init()
    
    
    var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    var body: some View {
        List(selection: $homeViewModel.selectionItems) {
            categoriesSection
            listsSection
            if !tags.isEmpty {
                tagsSection
            }
        }
        .sheet(item: $homeViewModel.homeNavigationSheetValues){$0}
        .searchable(text: .constant(""))
        .toolbar {
            ToolbarItemGroup(placement: isEditing ? .primaryAction : .secondaryAction) {
                toolbarItems
            }
            ToolbarItem(placement: .bottomBar) {
                BottomBar(homeNavigationValue: $homeViewModel.homeNavigationSheetValues)
            }
        }
        .task {
            await localNotificationManager.requestAuthorization()
        }
    }
}

struct HomeViewSubView: View {
    var body: some View {
        HomeView()
    }
}

//MARK: HOMEVIEW COMPONENTS
private extension HomeView {
    private var categoriesSection: some View {
        Section {
            if(isEditing){
                ForEach(reminderCategories){ reminderCategory in
                    ListRowItem(item: reminderCategory)
                        .padding(1)
                }
                .onMove { indices, newOffset in
                    print("Moving \(indices), \(newOffset)")
                }
            } else {
                CategoriesView(categories: reminderCategories)
            }
        }
        .listRowInsets(isEditing ? nil : .init())
        .listRowSpacing(isEditing ? nil : 8.0)
        .listRowBackground(isEditing ? nil : Color.clear)
    }
    
    private var listsSection: some View {
        Section {
            ForEach(reminderLists) { reminderList in
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
    
    private var tagsSection: some View {
        Section("Tags", isExpanded: .constant(true)) {
            ScrollView {
                HStack {
                    ForEach(tags) { tag in
                        RoundedRectangle(cornerRadius: 10)
                            .overlay {
                                Text(tag.name)
                                    .fontWeight(.semibold)
                            }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var toolbarItems: some View {
        Button {
            withAnimation() {
                if editMode?.wrappedValue == .active {
                    editMode?.wrappedValue = .inactive
                } else {
                    editMode?.wrappedValue = .active
                }
            }
        } label : {
            if isEditing {
                Text("Done")
            } else {
                LabeledContent("Edit Lists") {
                    Image(systemName: "pencil")
                }
            }
        }
        
        Group {
            if !isEditing {
                Button("Templates") {
                    homeViewModel.homeNavigationSheetValues = .templates
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(ReminderList.self, ReminderCategory.self)
    preview.addExamples(examples: ReminderList.examples)
    preview.addExamples(examples: ReminderCategory.examples)
    let navigationManager = NavigationManager()
    return HomeView()
        //.navigationStackWithDestination(for: NavigationValues.self, path: $navigationManager.navigationRoutes)
        .environmentObject(navigationManager)
        .environmentObject(LocalNotificationManager())
        .modelContainer(preview.container)
    //.preferredColorScheme(.dark)
}
