//
//  mindful_momentsApp.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/24/24.
//

import SwiftUI

@main
struct mindful_momentsApp: App {
    var body: some Scene {
        WindowGroup {
            
            //nav bar at the bottom of the screen
            //appears on all screens because the TabView is in the root WindowGroup
            TabView{
                NavigationView {
                    HomeView()
                }.tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                JournalEntriesView()
                    .tabItem {
                        Label("Journal Entries", systemImage: "book.circle")
                    }
                NewEntryView()
                    .tabItem {
                        Label("", systemImage: "plus.circle.fill")
                    }
                moodClass.MoodView()
                    .tabItem {
                        Label("Moods", systemImage: "chart.xyaxis.line")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
        }
    }
}
