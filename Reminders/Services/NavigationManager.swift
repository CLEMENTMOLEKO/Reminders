//
//  NavigationManager.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/06/17.
//

import SwiftUI

@MainActor
class NavigationManager: ObservableObject {
    /*TODO: why since we use this in a view extension and not passing it directly to NavigationStack we can't use anything else than NavigationPath*/
    @Published var navigationRoutes = NavigationPath()
    
    func navigate(to screen: NavigationValues) {
        navigationRoutes.append(screen)
    }
}
