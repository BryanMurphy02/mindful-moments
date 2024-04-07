//
//  MoodView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 2/26/24.
//

import SwiftUI
import Charts

class moodClass{
    
    let textProcessor = textProcessing()
    let journalEntriesData = JournalEntries()
    
    struct emotionData{
        let name: String
        var count: Int
    }
    
    var globalWeekData: [emotionData] = []
    
    //converting [String:Int] to emotionData
    func convertToEmotionData(dictionary: [String: Int]) -> [emotionData] {
        var result: [emotionData] = []
        for (name, count) in dictionary {
            let emotion = emotionData(name: name, count: count)
            result.append(emotion)
        }
        return result
    }
    
    //getting the data from the text processing and converting it to emotionData
    func getMoodData(data: String) -> [emotionData] {
        let processedData = textProcessor.runProcess(journalContent: data)
        return convertToEmotionData(dictionary: processedData)
    }
    
    //takes in entries and returns ones within the last week
    func entriesWithinLastWeek(entries: [JournalEntry]) -> [JournalEntry] {
        // Get the current date
        let currentDate = Date()
        
        // Calculate the date one week ago
        let oneWeekAgo = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
        
        // Filter the entries to only include those with dates within the last week
        let entriesWithinLastWeek = entries.filter { $0.date > oneWeekAgo }
        
        return entriesWithinLastWeek
    }
    
    //makes a solidified list of emotionData from entries in the past week
    func moodDataLastWeek(entries: [JournalEntry], weekEmotionData: inout [emotionData]){
        let lastWeek: [JournalEntry] = entriesWithinLastWeek(entries: entries)
        
        for entry in lastWeek {
            let emotions = getMoodData(data: entry.content)
            
            // Append each emotion from the array to weekEmotionData
            for emotion in emotions {
                // Check if the emotion already exists in weekEmotionData
                if let index = weekEmotionData.firstIndex(where: { $0.name == emotion.name }) {
                    // If it does, update the count
                    weekEmotionData[index].count += emotion.count
                } else {
                    // If not, append it to weekEmotionData
                    weekEmotionData.append(emotion)
                }
            }
        }
    }

    


    struct MoodView: View {
        let moodManager = moodClass()
        let entries = JournalEntries.entries
        @State private var selectedEntry: JournalEntry? = nil
        
        init() {
            // Populate globalWeekData when MoodView is initialized
            moodManager.moodDataLastWeek(entries: entries, weekEmotionData: &moodManager.globalWeekData)
        }
        
        var body: some View {
            VStack {
                Text("Mood Analysis") // Header
                    .font(.title)
                    .padding()
                Menu {
                    // Placeholder Section
                    Section(header: Text("Time Filters")) {
                        Button(action: {
                            // Action for placeholder menu option
                        }) {
                            Text("Past Week")
                        }
                    }
                    
                    // Journal Entries Section
                    Section(header: Text("Journal Entries")) {
                        ForEach(entries, id: \.id) { entry in
                            Button(action: {
                                selectedEntry = entry
                            }) {
                                Text("\(entry.date, formatter: DateFormatter.date)")
                            }
                        }
                    }
                } label: {
                    if let selectedEntry = selectedEntry {
                        Text("\(selectedEntry.date, formatter: DateFormatter.date)")
                            .font(.title2)
                    } else {
                        Text("Select Entry")
                            .font(.title2)
                    }
                }
                .padding()

                
                
                if let selectedEntry = selectedEntry {
                    GeometryReader { geometry in
                        pieChartView(journalEntry: selectedEntry.content)
                            .frame(width: min(geometry.size.width - 40, 550), // Adjust size as needed
                                   height: min(geometry.size.width - 40, 550)) // Adjust size as needed
                            .padding(.horizontal, 20) // Adjustable padding
                    }
                } else {
                    // Display the pie chart representing aggregated emotions data for the past week
                    GeometryReader { geometry in
                        weekPieChartView(emotions: moodManager.globalWeekData)
                            .frame(width: min(geometry.size.width - 40, 550),
                                   height: min(geometry.size.width - 40, 550))
                            .padding(.horizontal, 20)
                    }
                }

                
                Spacer() // Fill remaining space
            }
        }
    }

    
    //Main chart view
    struct pieChartView: View{
        let moodManager = moodClass()
        let journalEntry: String
        
        var body: some View {
            let data = moodManager.getMoodData(data: journalEntry)
            // Use Chart view from Charts framework
            Chart(data, id: \.name) { element in
                SectorMark(
                    angle: .value("Count", element.count),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Name", element.name))
            }
        }
    }
    
    //Week chart view
    struct weekPieChartView: View{
        let moodManager = moodClass()
        let emotions: [emotionData]
        
        init(emotions: [emotionData]) {
            self.emotions = emotions
        }
        
        var body: some View {
            // Use Chart view from Charts framework
            Chart(emotions, id: \.name) { element in
                SectorMark(
                    angle: .value("Count", element.count),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Name", element.name))
            }
        }
    }
    
    


    




}

