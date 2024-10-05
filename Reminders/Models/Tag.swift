//
//  Tag.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/09/01.
//

import Foundation
import SwiftData

@Model
class Tag {
    @Attribute(.unique)
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
