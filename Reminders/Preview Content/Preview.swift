//
//  Preview.swift
//  Reminders
//
//  Created by Clement Skosana on 2024/09/21.
//

import Foundation
import SwiftData

struct Preview {
    let container: ModelContainer
    
    init(_ model: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(model)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }
    
    func addExamples(examples: [any PersistentModel]) {
        examples.forEach { example in
            Task { @MainActor in
                container.mainContext.insert(example)
            }
        }
    }
}
