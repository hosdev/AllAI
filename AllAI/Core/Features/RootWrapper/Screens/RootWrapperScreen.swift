//
//  HomeScreen.swift
//  AllAI
//
//  Created by hosam abufasha on 28/02/2024.
//

import SwiftUI

struct RootWrapperScreen: View {
    @State var selection = 0
    var body: some View {
        TabView (selection: $selection) {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "homekit")
                }.tag(0)
            Text("History")
                .tabItem {
                    Label("History", systemImage: "clock")
                }.tag(1)
            
            Text("Statistics")
                .tabItem {
                    Label("Statistics", systemImage: "chart.line.uptrend.xyaxis")
                }.tag(2)
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "person.crop.circle.fill")
                }.tag(3)
            
        }
    }
}

#Preview {
    RootWrapperScreen()
}
