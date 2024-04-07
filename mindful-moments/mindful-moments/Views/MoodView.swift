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

    
    enum selectedItemType {
        case filter
        case entry
        case none
    }
    
    enum timeFilterType: String, CaseIterable {
        case pastWeek = "Past Week"
        case pastMonth = "Past Month"
    }

    struct MoodView: View {
        let moodManager = moodClass()
        let entries = JournalEntries.entries
        @State private var selectedEntry: JournalEntry? = nil
        @State private var selectedItemType: selectedItemType?

//        @State private var selectedFilter: timeFilterType = .pastWeek
        @State private var selectedFilter: timeFilterType?
        
        init() {
            // Populate globalWeekData when MoodView is initialized
            moodManager.moodDataLastWeek(entries: entries, weekEmotionData: &moodManager.globalWeekData)
        }
        
        var body: some View {
            
            VStack {
//                Text("Mood Analysis")
//                    .font(.title)
//                    .padding()
//                Text("Mood Analysis")
//                    .font(.system(size: 28, weight: .bold)) // Adjust font size and weight
//                    .padding()
//                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2) // Add shadow effect
//                    .scaleEffect(1.2) // Scale the text


                Menu {
                    // Time Filters Section
                    Section(header: Text("Time Filters")) {
                        ForEach(timeFilterType.allCases, id: \.self) { filterType in
                            Button(action: {
                                // Action for selecting time filter
                                selectedFilter = filterType
                                selectedItemType = .filter
                            }) {
                                Text(filterType.rawValue)
                            }
                        }
                    }
                    
                    // Journal Entries Section
                    Section(header: Text("Journal Entries")) {
                        ForEach(entries, id: \.id) { entry in
                            Button(action: {
                                selectedEntry = entry
                                selectedItemType = .entry
                            }) {
                                Text("\(entry.date, formatter: DateFormatter.date)")
                            }
                        }
                    }
                } label: {
                    if selectedItemType == .filter {
                        Text(selectedFilter!.rawValue + " Selected")
                            .font(.title2)
                    }
                    else if selectedItemType == .entry {
                        Text("\(selectedEntry!.date, formatter: DateFormatter.date)")
                            .font(.title2)
                    } else {
                        Text("Select Entry")
                            .font(.title2)
                    }
                }
                .padding()

                
                // Conditionally display the appropriate view based on selection
                if let selectedEntry = selectedEntry, selectedItemType == .entry {
                    GeometryReader { geometry in
                        pieChartView(journalEntry: selectedEntry.content)
                            .frame(width: min(geometry.size.width - 40, 550), // Adjust size as needed
                                   height: min(geometry.size.width - 40, 550)) // Adjust size as needed
                            .padding(.horizontal, 20) // Adjustable padding
                    }
                } else {
                    // Display the pie chart representing aggregated emotions data for the past week
                    Text("Emotions from the past Week")
                        .font(.title3)
                        .padding()
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
            .chartBackground { chartProxy in
              GeometryReader { geometry in
                  let frame = geometry[chartProxy.plotFrame!]
                VStack {
                  Text("Mood Analysis")
                        .font(.title)
//                    .foregroundStyle(.secondary)
                }
                .position(x: frame.midX, y: frame.midY)
              }
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
            .chartBackground { chartProxy in
              GeometryReader { geometry in
                  let frame = geometry[chartProxy.plotFrame!]
                VStack {
                  Text("Mood Analysis")
                        .font(.title)
//                    .foregroundStyle(.secondary)
                }
                .position(x: frame.midX, y: frame.midY)
              }
            }
        }
    }
    
    


    




}

