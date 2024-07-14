//
//  NewReminderView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/07/14.
//

import SwiftUI

struct NewReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: NewReminderViewModel = .init()
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $viewModel.title)
                TextField("Notes",text: $viewModel.notes)
                    .frame(height: 80, alignment: .topLeading)
            }
            
            Section {
                NavigationLink(value: NewReminderNavigationValues.details) {
                    Text("Details")
                }
            }
            
            Section {
//                NavigationLink(value: NewReminderNavigationValues.){
//                    ListRowItem(item: ListSelectionItem(name: "List", color: .orange, icon: "list.bullets"))
//                }
                Picker(selection: $viewModel.listType) {
                    ForEach(viewModel.reminderlists, id: \.name) { item in
                        Text(item.name)
                            .tag(item.name)
                    }
                } label: {
                    Label {
                        Text("List")
                    } icon: {
                        Image(systemName: "list.bullet")
                            .foregroundStyle(.white)
                            .padding(.horizontal,3)
                            .padding(.vertical, 6)
                            .background(.orange, in: RoundedRectangle(cornerRadius: 5))
                    }
                }
                .pickerStyle(.navigationLink)
            }
        }
        .navigationTitle("New Reminder")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    
                }
                .disabled(true)
            }
        }
    }
}

struct ListSelectionItem: ListItem {
    var name: String
    var color: Color
    var icon: String
}

#Preview {
    NavigationStack {
        NewReminderView()
    }
}
