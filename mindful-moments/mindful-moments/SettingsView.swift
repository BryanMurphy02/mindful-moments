//
//  SettingsView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/26/24.
//

import SwiftUI

struct SettingsView: View {
    
    //state variables for toggle
    @State var passwordLock = true
    @State var aiGeneration = true
    
    
    var body: some View {
        VStack{
            //this HStack will be for the back button in the top left
//            HStack{
//                Button(action: {
//    //                    put action here
//                }) {
//                    Image(systemName: "arrow.backward")
//                        .padding(.trailing, 300.0)
//                        
//                }
//            }
//            Spacer()
            NavigationView{
                List {
                    Section(header: Text("General")) {
                        SettingsToggleRow(icon: "lock.fill", title: "Password Lock", caption: "test caption", isToggled: $passwordLock)
                        SettingsDestinationRow(icon: "bell.fill", title: "Notifications", destination: NotificationsView())
                        SettingsToggleRow(icon: "brain.filled.head.profile", title: "AI Generation", caption: "test caption", isToggled: $aiGeneration)
                    }
                    Section(header: Text("Appearances")) {
                        
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Settings")
            }
        }
    }
}

//This struct sets it up to bring the user to a new page when clicking on the item
struct SettingsDestinationRow<Destination: View>: View {
    var icon: String //icon
    var title: String //title of setting
    var destination: Destination //page to be directed to
    
    var body: some View {
        NavigationLink(destination: destination){
            HStack{
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .font(.headline)
                Text(title)
            }
        }
    }
}

//This struct is set up to be a toggle for the setting
struct SettingsToggleRow: View {
    var icon: String
    var title: String
    var caption: String
    @Binding var isToggled: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.headline)
            VStack(alignment: .leading) {
                Text(title)
                Text(caption) // Show caption below the title
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Spacer()
            Toggle("", isOn: $isToggled)
                .labelsHidden()
        }
    }
}

#Preview {
    SettingsView()
}
