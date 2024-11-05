//
//  SamplePokemon.swift
//  Dex3
//
//  Created by Weerawut Chaiyasomboon on 4/11/2567 BE.
//

import Foundation
import CoreData

@MainActor
struct SamplePokemon{
    static let samplePokemon = {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try! context.fetch(fetchRequest)
        
        return results.first!
    }()
}
