//
//  NewListView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/30.
//

import SwiftUI

struct NewListView: View {
    @Environment(\.dismiss) var dismiss
    
    enum Segment: String, CaseIterable, Identifiable {
        case newList = "New List"
        case templates = "Templates"
        
        var id: String { self.rawValue }
    }
    
    @State private var selectedSegment: Segment = .newList
    @State var listName = ""
    
    var body: some View {
        List {
            Section {
                VStack {
                    Circle()
                        .fill(.blue.opacity(0.8)) //TODO: this will be a random color.
                        .frame(width: 85)
                        .overlay {
                            Image(systemName: "list.bullet")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                        }
                    
                    TextField(text: $listName) {
                        Text("List Name")
                            .font(.system(size: 20, design: .rounded))
                            .fontWeight(.bold)
                    }
                    .padding()
                    .background(alignment: .center) {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color(uiColor: .systemFill))
                    }
                }
            }
        }
        .navigationTitle("New List")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                   dismiss()
                }
            }
            
//            ToolbarItem(placement: .principal) {
//                Picker("Select a segment", selection: $selectedSegment) {
//                    ForEach(Segment.allCases) { segment in
//                        Text(segment.rawValue).tag(segment)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//
//            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    //TODO: user context to insert or save in SwifData.
                    dismiss()
                }
                .disabled(true)
            }
        }
    }
}

#Preview {
    NavigationStack {
     NewListView()
        .preferredColorScheme(.dark)   
    }
    
}
