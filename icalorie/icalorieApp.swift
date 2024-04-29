//
//  icalorieApp.swift
//  icalorie
//
//  Created by Jannik Scheider on 27.04.24.
//

import SwiftUI

@main
struct icalorieApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
