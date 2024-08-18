//
//  HomeViewModel.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/03/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var homeSearchValue: String = ""
    @Published var homeNavigationSheetValues: HomeNavigationSheeValues? = nil
    @Published var selectionItems = Set<ReminderCategory.ID>()
}
