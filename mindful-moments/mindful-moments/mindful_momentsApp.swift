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
//import SwiftUI
//
//@main
//struct mindful_momentsApp: App {
//    @StateObject private var dataController = DataController()
//    @State private var selectedTab = 0
//
//    var body: some Scene {
//        WindowGroup {
//            rootView()
//                .environment(\.managedObjectContext,
//                              dataController.container.viewContext)
//        }
//    }
//}
//
//func goHome() {
//    //@StateObject var dataController: DataController
//    @EnvironmentObject var dataController: DataController
//
//    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//       let window = windowScene.windows.first {
//        window.rootViewController = UIHostingController(rootView: rootView()
//                .environment(\.managedObjectContext,
//                          dataController.container.viewContext)
//                                                        
//        window.makeKeyAndVisible()
//    }
//}
//
//struct rootView: View {
//    //@StateObject var dataController: DataController
//    @Environment(\.managedObjectContext) var managedObjContext
//    @State private var selectedTab = 0
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            NavigationView {
//                HomeView()
//                    .environment(\.managedObjectContext,
//                                  managedObjContext)
//            }
//            .tabItem {
//                Label("Home", systemImage: "house.fill")
//            }
//            .tag(0)
//
//            JournalView()
//                .environment(\.managedObjectContext,
//                              managedObjContext)
//                .tabItem {
//                    Label("Journal Entries", systemImage: "book.circle")
//                }
//                .tag(1)
//
//            NewEntryView()
//                .environment(\.managedObjectContext,
//                              managedObjContext)
//                .tabItem {
//                    Label("", systemImage: "plus.circle.fill")
//                }
//                .tag(2)
//
//            moodClass.MoodView()
//                .environment(\.managedObjectContext,
//                              managedObjContext)
//                .tabItem {
//                    Label("Moods", systemImage: "chart.xyaxis.line")
//                }
//                .tag(3)
//
//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gearshape")
//                }
//                .tag(4)
//        }
//        .onAppear {
//            // Do any setup or initial data loading here
//        }
//    }
//}
