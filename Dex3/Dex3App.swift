//
//  Dex3App.swift
//  Dex3
//
//  Created by Weerawut Chaiyasomboon on 3/11/2567 BE.
//

import SwiftUI

@main
struct Dex3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
