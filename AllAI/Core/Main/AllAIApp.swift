//
//  AllAIApp.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import SwiftUI

@main
struct AllAIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthApp())
        }
    }
}
