//
//  SettingsThemeView.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 4/8/24.
//

import SwiftUI

struct SettingsThemeView: View {
    @State var darkMode = true
    
    var body: some View {
            List {
                Section(header: Text("Section Header")) {//paintbrush.fill
                    SettingsToggleRow(icon: "paintbrush.fill", title: "Dark Mode", caption: "Toggle Dark Mode and Light Mode", isToggled: $darkMode)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Theme")
    }
}
