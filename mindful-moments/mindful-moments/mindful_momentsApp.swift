//
//  SampleCoreDataApp.swift
//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
//

import SwiftUI

@main
struct mindful_momentsApp: App {
    @StateObject private var dataController = DataController()
    @State private var selectedTab = 0

    var body: some Scene {
        WindowGroup {
            //nav bar at the bottom of the screen
            //appears on all screens because the TabView is in the root WindowGroup
            TabView{
                NavigationView {
                    HomeView()
                        .environment(\.managedObjectContext,
                                      dataController.container.viewContext)
                }.tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                JournalView()
                    .environment(\.managedObjectContext,
                                  dataController.container.viewContext)
                    .tabItem {
                        Label("Journal Entries", systemImage: "book.circle")
                    }
                NewEntryView()
                    .environment(\.managedObjectContext,
                                  dataController.container.viewContext)
                    .tabItem {
                        Label("", systemImage: "plus.circle.fill")
                    }
                moodClass.MoodView()
                    .environment(\.managedObjectContext,
                                  dataController.container.viewContext)
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
