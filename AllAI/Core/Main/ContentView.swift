//
//  ContentView.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var authApp : AuthApp
    var body: some View {
        
        
        if authApp.loggedIn {
            Text("Hi")
        } else {
            OnboardingScreen()
        }
        
    }
}

#Preview {
    ContentView()
}
