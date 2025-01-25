//
//  NewReminderDetails.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/08/17.
//

import SwiftUI
import SwiftData

struct NewReminderDetails: View {
    @State var date: Date = Date.distantPast
    @State var time: Date = Date.distantPast
    @State var isDateEnabled = false
    @State var isTimeEnabled = false
    @Query var selectedReminder: [Tag]
    
    var body: some View {
        Form {
            dateSection
            tagsSection
        }
    }
    
    private var dateSection: some View {
        Section {
            Toggle(isOn: $isDateEnabled){
                labelRow(
                    title: "Date",
                    icon: "calendar",
                    backgroundColor: Color.red.opacity(0.8),
                    subtitle: date.formatted(
                        date: .complete,
                        time: .omitted
                    )
                )
            }
            if isDateEnabled {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.graphical)
            }
            Toggle(isOn: $isTimeEnabled){
                labelRow(
                    title: "Time",
                    icon: "clock.fill",
                    backgroundColor: Color.red.opacity(0.8)
                )
            }
            if isTimeEnabled {
                DatePicker("Date", selection: $time, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
            }
        }
        .animation(.spring, value: isDateEnabled)
    }
    
    private var tagsSection: some View {
        Section {
            NavigationLink(value: "Tag") {
                labelRow(title: "Tags", icon: "number", backgroundColor: Color.gray)
            }
        }
    }
    
    private func labelRow(
        title: String,
        icon: String,
        backgroundColor: Color,
        subtitle: String? = nil
    ) -> some View {
        Label {
            VStack(alignment: .leading){
                Text(title)
                if let subtitle {
                    Text(subtitle)
                    .font(.caption)
                }
            }
        } icon: {
           Image(systemName: icon)
                .padding(6)
                .background(backgroundColor, in: RoundedRectangle(cornerRadius: 5))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    NavigationStack {
        NewReminderDetails()
    }
}
