//
//  View+.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/17.
//

import SwiftUI

extension View {
    func navigationStackWithDestination<T>(
        for value: T.Type,
        path: Binding<NavigationPath>
    ) -> some View  where T : Hashable & View {
        NavigationStack(path: path){
            self
                .navigationDestination(for: value) { $0 }
        }
    }
}
