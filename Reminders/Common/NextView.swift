//
//  NextView.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/04/21.
//

import SwiftUI

enum ScreenType: String, Identifiable {
    case renew, promo
    var id: String {
        self.rawValue
    }
    
    @ViewBuilder
    func view() -> some View {
        switch self {
        case .renew:
            Text("The renew")
                .font(.largeTitle)
        case .promo:
            VStack {
                Text("Promotion demo screen")
                    .font(.largeTitle)
                Image(systemName: "party.popper.fill")
            }
        }
    }
}
