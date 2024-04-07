//
//  HomeView.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/14/24.
//

import SwiftUI

let journalEntries = JournalEntries() //TODO: convert to coreData

//calculates the streak of entries
func streakCalc(entries: [JournalEntry]) -> Int {
    var currentStreak = 0
    var currentDate = Date()
    var remainingEntries = entries // Make a copy of the entries array
    
    // Iterate backward starting from today
    while let entry = remainingEntries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDate) }) {
        currentStreak += 1
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        remainingEntries.removeAll(where: { Calendar.current.isDate($0.date, inSameDayAs: entry.date) })
    }
    
    return currentStreak
}



struct HomeView: View {
    
    // Computed property to get the current time in a formatted string
    private var formattedCurrentTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(formattedCurrentTime)
                .font(.custom("Avenir Next", size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(15)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .cornerRadius(20)
                        .shadow(color: .black, radius: 10, x: 0, y: 0)
                )

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
                    .padding()
            }
            .padding(35)
            WidgetView(title: "Streaks") {
                StreakWidgetView()
            }
            .padding(.top, 20)
            .padding(.bottom, 15)
            WidgetView(title: "Prompt") {
                PromptWidgetView()
            }
            .padding(35)
        }
        .padding()
    }
}



struct WidgetView<Content: View>: View {
    var title: String
    var content: () -> Content
    
    var body: some View {
        ZStack {
            // Background: Linear gradient with rounded corners and shadow
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(20)
                .shadow(color: .black, radius: 10, x: 0, y: 0)
            
            // Content: Title and custom content
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 5)
                
                content()
            }
//            .padding(20)
        }
        .frame(width: 350, height: 100)
    }
}


struct TemplatesWidgetView: View {
    var body: some View {
        HStack {
            Spacer()
            
            //Morning
            //TODO: add window like others
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
            Spacer()
            HStack{
                let streak = streakCalc(entries: JournalEntries.entries)
                Text("\(streak) Days!")
                    .font(.title)
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .font(.title)
            }
            Spacer()
        }
    }
}

struct PromptWidgetView: View {
    let promptFile = prompts()
    
    @State private var prompt: String // Define a @State variable to hold the prompt text
        
    init() {
        _prompt = State(initialValue: promptFile.getRandomPrompt(from: promptFile.prompts)!)
    }
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.prompt = self.promptFile.getRandomPrompt(from: self.promptFile.prompts)!
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
            Text(prompt)
                .padding(20)
                .multilineTextAlignment(.center)
                .lineSpacing(8) // Adjust line spacing as needed
                .fixedSize(horizontal: false, vertical: true) // Allow the text to wrap to multiple lines

            Spacer()

        }
    }
}
