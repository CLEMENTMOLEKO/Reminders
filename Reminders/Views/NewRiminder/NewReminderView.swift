//
//  NewReminderView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/07/14.
//

import SwiftUI
import SwiftData

struct NewReminderView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: NewReminderViewModel = .init()
    @Query(sort: \ReminderList.name) private var reminderListsPicker: [ReminderList]
    
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
                Picker(selection: $viewModel.reminderName) {
                    ForEach(reminderListsPicker) { item in
                        Text(item.name).tag(item.name)
                    }
                } label: {
                    Label {
                        Text("List")
                    } icon: {
                        if let item = reminderListsPicker.first {
                            Image(systemName: item.icon)
                                .foregroundStyle(.white)
                                .padding(.horizontal,3)
                                .padding(.vertical, 6)
                                .background(item.color.color, in: RoundedRectangle(cornerRadius: 5))
                        }
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

#Preview {
    NavigationStack {
        NewReminderView()
    }
}
