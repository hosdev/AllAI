//
//  ContentView.swift
//  AllAI
//
//  Created by hosam abufasha on 20/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthAppModel.self) var authApp : AuthAppModel
    
    var body: some View {
        
        Group {
            if authApp.loggedIn {
                RootWrapperScreen()
            } else {
                OnboardingScreen()
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
