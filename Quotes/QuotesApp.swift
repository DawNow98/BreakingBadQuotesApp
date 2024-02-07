//
//  QuotesApp.swift
//  Quotes
//
//  Created by Dawid Nowacki on 04/02/2024.
//

import SwiftUI

@main
struct QuotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
