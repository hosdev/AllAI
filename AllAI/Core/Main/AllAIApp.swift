//
//  AllAIApp.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}


@main
struct AllAIApp: App {
    
    init() {
        FirebaseApp.configure()
        auth.getCurrentUser()
    }
    
    @State private var auth = AuthAppModel()
    @State private var chatModel = ChatModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(auth).environment(chatModel)
        }
    }
}

