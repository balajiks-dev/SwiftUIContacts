//
//  MovieWatchApp.swift
//  MovieWatch
//
//  Created by Balaji Sundaram on 21/08/20.
//

import SwiftUI

@main
struct MovieWatchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
