//
//  HomeView.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/14/24.
//

import SwiftUI

struct HomeView: View {
    
    // Computed property to get the current time in a formatted string
    private var formattedCurrentTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    var body: some View {
        VStack {
            //Settings
            HStack {
                Spacer()
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                        .padding()
                }
            }
            
            // Time
            Text(formattedCurrentTime)
                .font(.title)
                .padding()
            
            // Widget list (templates, streak, prompt)
            WidgetListView()
            
            Spacer()
        }
    }
}

struct WidgetListView: View {
    var body: some View {
        VStack(spacing: 20) {
            WidgetView(title: "Templates") {
                TemplatesWidgetView()
            }
            
            WidgetView(title: "Streaks") {
                StreakWidgetView()
            }
            
            WidgetView(title: "Prompt") {
                PromptWidgetView()
            }
        }
        .padding()
    }
}

struct WidgetView<Content: View>: View {
    var title: String
    var content: () -> Content
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(.blue)
            .frame(width: 350, height: 130)
            .overlay(
                VStack {
                    content()
                }
            )
    }
}

struct TemplatesWidgetView: View {
    var body: some View {
        HStack {
            Spacer()
            
            //Morning
            NavigationLink(destination: NewEntryView()) {
                VStack{
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 64))
                    Text("Morning")
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            //Night
            NavigationLink(destination: NewEntryView()) {
                VStack{
                    Image(systemName: "moon.stars.fill")
                        .foregroundColor(.purple)
                        .font(.system(size: 64))
                    Text("Night")
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            //Diary
            NavigationLink(destination: NewEntryView()) {
                VStack{
                    Image(systemName: "book.closed.fill")
                        .foregroundColor(.brown)
                        .font(.system(size: 64))
                    Text("Diary")
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
        }
    }
}

struct StreakWidgetView: View {
    var body: some View {
        VStack {
            Text("Current Streak")
                .font(.system(size: 28))
                .padding()
            
            HStack{
                Text("Placeholder Days!")
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
            }
            
            Spacer()
            
        }
    }
}

struct PromptWidgetView: View {
    var body: some View {
        VStack {
            Text("Daily Prompt")
                .font(.system(size: 28))
                .padding()
            
                Text("Placeholder Prompt")
            
            Spacer()
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
