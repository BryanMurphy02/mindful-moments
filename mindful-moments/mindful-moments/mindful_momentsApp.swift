//
//  mindful_momentsApp.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/24/24.
//

import SwiftUI

@main
struct mindful_momentsApp: App {
    @StateObject private var dataController = DataController()
    
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
                    //.environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
                    .tabItem {
                        Label("Journal Entries", systemImage: "book.circle")
                    }
                NewEntryView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(dataController)
                    .tabItem {
                        Label("", systemImage: "plus.circle.fill")
                    }
                CalendarView()
                    .tabItem {
                        Label("Calendar", systemImage: "calendar.circle")
                    }
                MoodView()
                    .tabItem {
                        Label("Moods", systemImage: "chart.xyaxis.line")
                    }
            }
        }
    }
}
