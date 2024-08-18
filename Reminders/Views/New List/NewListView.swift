//
//  NewListView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/30.
//

import SwiftUI
import SwiftData
import SymbolPicker

struct NewListView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedSegment: Segment = .newList
    @State var listName = ""
    @State var newListType: ListType = .standard
    @State var listColor: Color = .blue
    @State var isSymbolPickerPresented = false
    @State var listSymbol: String = "list.bullet"
    
    var body: some View {
        List {
            listNameSection
            listTypeSection
            colorPickerList
            Section {
                LabeledContent {
                    Button {
                        isSymbolPickerPresented.toggle()
                    } label: {
                        Image(systemName: listSymbol)
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(listColor, in: RoundedRectangle(cornerRadius: 5))
                    }

                } label: {
                    Text("List Type")
                }

            }
        }
        .navigationTitle("New List")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isSymbolPickerPresented) {
            //TODO: wrap this in a view incase it's used in other places.
            SymbolPicker(symbol: $listSymbol)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                   dismiss()
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Picker("Select a segment", selection: $selectedSegment) {
                    ForEach(Segment.allCases) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    //TODO: user context to insert or save in SwifData.
                    let list = ReminderList(name: listName, color: ColorComponents.fromColor(listColor), icon: listSymbol)
                    context.insert(list)
                    dismiss()
                }
                .disabled(listName.isEmpty)
            }
        }
    }
}

//MARK: Components
extension NewListView {
    private var listNameSection: some View {
        Section {
            VStack {
                Circle()
                    .fill(listColor.opacity(0.8)) //TODO: this will be a random color.
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
    
    private var listTypeSection: some View {
        Section {
            Picker(selection: $newListType) {
                ForEach(ListType.allCases) { listType in
                    Text("\(listType.rawValue)")
                        .tag(listType)
                }
            } label: {
                Label {
                    Text("List Type")
                } icon: {
                    Image(systemName: "list.bullet")
                        .foregroundStyle(.white)
                        .padding(.horizontal,3)
                        .padding(.vertical, 6)
                        .background(listColor, in: RoundedRectangle(cornerRadius: 5))
                }
            }
        }
    }
    
    private var colorPickerList: some View {
        ColorPicker("List Icon Color", selection: $listColor)
    }
}

//MARK: Enums
extension NewListView {
    enum ListType: String, Identifiable, CaseIterable {
        case standard = "Standard"
        case shopping = "Shopping"
        case smartList = "Smart List"
    
        var id: Self { self }
    }
    
    enum Segment: String, CaseIterable, Identifiable {
        case newList = "New List"
        case templates = "Templates"
        
        var id: String { self.rawValue }
    }
}

#Preview {
    NavigationStack {
     NewListView()
        .preferredColorScheme(.dark)   
    }
    
}
