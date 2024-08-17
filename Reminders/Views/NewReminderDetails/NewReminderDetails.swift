//
//  NewReminderDetails.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/08/17.
//

import SwiftUI

struct NewReminderDetails: View {
    @State var date: Date = Date.distantPast
    @State var time: Date = Date.distantPast
    @State var isDateEnabled = false
    @State var isTimeEnabled = false
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter
    }
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $isDateEnabled){
                    Label {
                        VStack(alignment: .leading){
                            Text("Date")
                            Text(date.formatted(date: .complete, time: .omitted))
                                .font(.caption)
                        }
                    } icon: {
                       Image(systemName: "calendar")
                            .padding(6)
                            .background(Color.red.opacity(0.8), in: RoundedRectangle(cornerRadius: 5))
                            .foregroundStyle(.white)
                    }
                }
                if isDateEnabled {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                }
                Toggle(isOn: $isTimeEnabled){
                    Label {
                        Text("Time")
                    } icon: {
                       Image(systemName: "clock.fill")
                            .padding(6)
                            .background(Color.red.opacity(0.8), in: RoundedRectangle(cornerRadius: 5))
                            .foregroundStyle(.white)
                    }
                }
                if isTimeEnabled {
                    DatePicker("Date", selection: $time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewReminderDetails()
    }
}
