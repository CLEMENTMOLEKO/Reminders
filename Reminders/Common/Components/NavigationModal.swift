//
//  NavigationModal.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/30.
//

import SwiftUI

/// Presents a sheet when a binding to a Boolean value that you
/// provide is true.
///
/// Use this view when you want to present a modal view to the
/// user when a Boolean value you provide is true, and that modal
/// will have navigation stack within it meaning the `content`
/// will be within a navigation stack and have navigation destination for.
/// The example below displays a modal view of the mockup for a software license
/// agreement when the user toggles the `isShowingSheet` variable by
/// clicking or tapping on the "Show License Agreement" button:
///
///     struct ShowLicenseAgreement: View {
///         @State private var isShowingSheet = false
///         var body: some View {
///            NavigationModal(isPresented: $isShowingSheet) {
///               Text("Test Navigation Modal")
///            } action: {
///                isShowSheet.toggle()
///            } label: {
///                HStack {
///                    Image(systemName: "plus.circle.fill")
///                    Text("New Reminder")
///                }
///                .font(.headline)
///            }
///         }
///
///         func didDismiss() {
///             // Handle the dismissing action.
///         }
///     }
///
///
/// - Parameters:
///   - value: The enum type responsible for enum navigaiton
///   - path: The navigation Path for the navigation stack the content will be within
///   - isPresented: A binding to a Boolean value that determines whether
///     to present the sheet containing `content` closure.
///   - onDismiss: The closure to execute when dismissing the sheet.
///   - content: A closure that returns the content of the sheet.
///   - label: A label for the button to click in order to show the sheet.
struct NavigationModal<Label: View, Content: View, T: Hashable & View>: View {
    internal init(
        for value: T.Type,
        path: Binding<NavigationPath>,
        isPresented: Binding<Bool>,
        content: @escaping () -> Content,
        action: @escaping () -> Void,
        onDismiss: (() -> Void)? = nil,
        label: @escaping () -> Label
    ) {
        self.value = value
        self.path = path
        self._isPresented = isPresented
        self.content = content
        self.action = action
        self.onDismiss = onDismiss
        self.label = label
    }
    
    var value: T.Type
    var path: Binding<NavigationPath>
    @Binding var isPresented: Bool
    @ViewBuilder var content: () -> Content
    var action: () -> Void
    var onDismiss: (() -> Void)? = nil
    @ViewBuilder var label: () -> Label
    
    var body: some View {
        Button(action: action, label: label)
            .sheet(isPresented: $isPresented, onDismiss: onDismiss ) {
                content()
                    .navigationStackWithDestination(for: T.self, path: path)
            }
    }
}

#Preview {
    NavigationModal(
        for: NavigationValues.self,
        path:.constant(NavigationPath()),
        isPresented: .constant(false)
    ) {
        Text("button view")
    } action: {
        
    } label: {
       Text("Test Nav Modal")
    }
}
