//
//  NavigationManager.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/17.
//

import Foundation

@MainActor
class NavigationManager: ObservableObject {
    @Published var navigationRoutes = [NavigationValues]()
    
    func navigate(to screen: NavigationValues) {
        navigationRoutes.append(screen)
    }
}
