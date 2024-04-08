//
//  NotificationsView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 3/7/24.
//

import SwiftUI

struct NotificationsView: View {
    //State variables
    @State var setting1 = false
    @State var setting2 = false
    @State var setting3 = false
    @State var setting4 = false
    @State var setting5 = false
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    Section(header: Text("Types")) {
                        SettingsToggleRow(icon: "bell.fill", title: "Daily Reflection", caption: "", isToggled: $setting1)
                        SettingsToggleRow(icon: "bell.fill", title: "Mood Check-in", caption: "", isToggled: $setting2)
                        SettingsToggleRow(icon: "bell.fill", title: "Setting Three", caption: "", isToggled: $setting3)
                        SettingsToggleRow(icon: "bell.fill", title: "Setting Four", caption: "", isToggled: $setting4)
                        SettingsToggleRow(icon: "bell.fill", title: "Setting Five", caption: "", isToggled: $setting5)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Notification Settings")
            }
        }
    }
}

#Preview {
    NotificationsView()
}
