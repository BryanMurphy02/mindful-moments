//
//  HomeView.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/14/24.
//

import SwiftUI

let journalEntries = JournalEntries()

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
            //Settings
            
            // Time
//            Text(formattedCurrentTime)
//                .font(.title)
//                .padding()
//            Text(formattedCurrentTime)
//                .font(.custom("Arial", size: 80))
//                .fontWeight(.bold)
//                .padding(20)
//                .foregroundColor(.white)
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color.blue)
//                        .shadow(color: .gray, radius: 5, x: 0, y: 0)
//                )
            Text(formattedCurrentTime)
                .font(.custom("Avenir Next", size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(30)
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
            .padding(35)
            WidgetView(title: "Prompt") {
                PromptWidgetView()
            }
            .padding(35)
        }
        .padding()
    }
}



//struct WidgetView<Content: View>: View {
//    var title: String
//    var content: () -> Content
//    
//    var body: some View {
//        RoundedRectangle(cornerRadius: 10)
//            .foregroundColor(.blue)
//            .frame(width: 350, height: 130)
//            .overlay(
//                VStack {
//                    content()
//                }
//            )
//    }
//}
//struct WidgetView<Content: View>: View {
//    var title: String
//    var content: () -> Content
//    
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .cornerRadius(20)
//                .shadow(color: .black, radius: 10, x: 0, y: 0)
//            VStack {
//                Text(title)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.top, 10)
//                content()
//            }
//            .padding(20)
//        }
//        .frame(width: 350, height: 130)
//    }
//}

//originasl
//var body: some View {
//    RoundedRectangle(cornerRadius: 10)
//        .foregroundColor(.blue)
//        .frame(width: 350, height: 130)
//        .overlay(
//            VStack {
//                content()
//            }
//        )
//}

//struct WidgetView<Content: View>: View {
//    var title: String
//    var content: () -> Content
//    
//    var body: some View {
////        ZStack {
////            
////            .padding(20) // Reduced padding
////        }
////        .frame(width: 350, height: 130) // Reduced frame size
//        ZStack{
//            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .cornerRadius(20)
//                .shadow(color: .black, radius: 10, x: 0, y: 0)
//            VStack {
//                Text(title)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding(.top, 10) // Reduced top padding
//                content()
//            }
//        }
//        .overlay(
//            VStack{
//                content()
//            }
//        )
//        .frame(width: 350, height: 130)
//    }
//}
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
                    .padding(.top, 2)
                
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
                let streak = streakCalc(entries: JournalEntries.entries)
                Text("\(streak) Days!")
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
