//
//  InsightOutApp.swift
//  Shared
//
//  Created by Kevin Peng on 2021-11-05.
//

import SwiftUI
import InsightOut

@main
struct InsightOutApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Loader(context: CoreDataStack.shared.context))
        }
    }
}
