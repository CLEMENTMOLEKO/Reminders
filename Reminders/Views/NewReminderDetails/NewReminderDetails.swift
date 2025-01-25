//
//  NewReminderDetails.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/08/17.
//

import SwiftUI
import SwiftData

struct NewReminderDetails: View {
    //TODO: Take values to a view model
    @State var date: Date = Date.distantPast
    @State var time: Date = Date.distantPast
    @State var isDateEnabled = false
    @State var isTimeEnabled = false
    @State var isLocationEnabled = false
    @Query var selectedReminder: [Tag]
    
    var body: some View {
        Form {
            dateSection
            tagsSection
            locationSection
        }
    }
    
    private var dateSection: some View {
        Section {
            Toggle(isOn: $isDateEnabled){
                labelRow(
                    title: "Date",
                    icon: "calendar",
                    backgroundColor: .red.opacity(0.8),
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
                    backgroundColor: .blue
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
                labelRow(title: "Tags", icon: "number", backgroundColor: .gray)
            }
        }
    }
    
    private var locationSection: some View {
        Section {
            Toggle(isOn: $isLocationEnabled) {
                labelRow(title: "Location", icon: "location.fill", backgroundColor: .blue)
            }
            
            if isLocationEnabled {
                HStack {
                    ForEach(LocationMode.allCases) { mode in
                        locationItem(locationMode: mode)
                    }
                }
                .frame(maxWidth: .infinity)
                Text("Add location value")
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
    
    private func locationItem(
        locationMode: LocationMode
    ) -> some View {
        VStack {
            Circle()
                .fill(locationMode.color)
                .frame(width: 60, height: 60)
                .overlay {
                    Image(systemName: locationMode.systemImage)
                        .font(.title2)
                        .foregroundStyle(.white)
                }
            Text(locationMode.text)
                .font(.subheadline)
        }
    }
    
    enum LocationMode: String, CaseIterable, Identifiable {
        case current, gettingIn, gettingOut, custom
       
        var id: Self { self }
        
        var systemImage: String {
            switch self {
            case .current:
                return "location.fill"
            case .gettingIn,.gettingOut:
                return "car.fill"
            case .custom:
                return "ellipsis"
            }
        }
        
        var text: String {
            switch self {
            case .current, .custom:
                return self.rawValue.capitalized
            case .gettingIn:
                return "Getting in"
            case .gettingOut:
                return "Getting out"
            }
        }
        
        var color: Color {
            switch self {
            case .current, .custom:
                return .gray.opacity(0.7)
            case .gettingIn,.gettingOut:
                return .blue.opacity(0.8)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewReminderDetails()
    }
}
