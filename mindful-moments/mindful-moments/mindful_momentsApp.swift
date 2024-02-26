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
                ContentView()
                    .tabItem {
                        Label("Journal Entries", systemImage: "book.circle")
                    }
                MoodView()
                    .tabItem {
                        Label("Moods", systemImage: "chart.xyaxis.line")
                    }
                NewEntryView()
                    .tabItem {
                        Label("New Entry", systemImage: "plus.circle.fill")
                    }
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar.circle")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
        }
    }
}
