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
//    func entriesWithinLastWeek(entries: [Entry]) -> [Entry] {
//        // Get the current date
//        let currentDate = Date()
//        
//        // Calculate the date one week ago
//        let oneWeekAgo = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentDate)!
//        
//        // Filter the entries to only include those with dates within the last week
//        let entriesWithinLastWeek = entries.filter { $0.date! > oneWeekAgo }
//        
//        return entriesWithinLastWeek
//    }
    func entriesWithinLastWeek(entries: [Entry]) -> [Entry] {
        // Get the current date
        let currentDate = Date()
        
        // Calculate the date one week ago
        guard let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentDate) else {
            return []
        }
        
        // Filter the entries to only include those with dates on or after one week ago
        let entriesWithinLastWeek = entries.filter { entry in
            if let entryDate = entry.date {
                return entryDate >= oneWeekAgo
            }
            return false // handle case where entry.date is nil
        }
        
        return entriesWithinLastWeek
    }


    
    //makes a solidified list of emotionData from entries in the past week
    func moodDataLastWeek(entries: [Entry]){
        let lastWeek: [Entry] = entriesWithinLastWeek(entries: entries)
        print("Last Week: \(lastWeek)")
        
        for entry in lastWeek {
            let emotions = getMoodData(data: entry.content ?? "")
            
            // Append each emotion from the array to weekEmotionData
            for emotion in emotions {
                // Check if the emotion already exists in weekEmotionData
                if let index = globalWeekData.firstIndex(where: { $0.name == emotion.name }) {
                    // If it does, update the count
                    globalWeekData[index].count += emotion.count
                } else {
                    // If not, append it to weekEmotionData
                    globalWeekData.append(emotion)
                }
            }
        }
    }
    
    func extractContent(entries: [Entry]) -> [String] {
        return entries.map { $0.content! }
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
        @Environment(\.managedObjectContext) var managedObjContext
        @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var entry: FetchedResults<Entry>
        
        let moodManager = moodClass()
        var entries: [Entry] {
            entry.map { $0 }
        }
        @State private var selectedEntry: Entry? = nil
        @State private var selectedItemType: selectedItemType?

//        @State private var selectedFilter: timeFilterType = .pastWeek
        @State private var selectedFilter: timeFilterType?
        
        init() {
            // Populate globalWeekData when MoodView is initialized

//            moodManager.moodDataLastWeek(entries: entries)
//            
//            print(moodManager.globalWeekData)
            
            moodManager.globalWeekData = [
                emotionData(name: "fear", count: 7),
                emotionData(name: "anger", count: 12),
                emotionData(name: "disgust", count: 4),
                emotionData(name: "surprise", count: 18),
                emotionData(name: "happy", count: 10)
            ]
        }
        
        var body: some View {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
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
                                Text("\(entry.date!, formatter: DateFormatter.date)")
                            }
                        }
                    }
                } label: {
                    if selectedItemType == .filter {
                        HStack{
                            Text(selectedFilter!.rawValue)
//                                .font(.title2)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            Image(systemName: "calendar")
                                .font(.title)
                        }
                    }
                    else if selectedItemType == .entry {
                        HStack{
                            Text("\(selectedEntry!.date!, formatter: DateFormatter.date)")
//                                .font(.title2)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            Image(systemName: "calendar")
                                .font(.title)
                        }
                    }else {
                        HStack{
                            Text("Past Week")
//                                .font(.title2)
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            Image(systemName: "calendar")
                                .font(.title)
                        }
                    }
                }
                .padding()

                
                // Conditionally display the appropriate view based on selection
                if let selectedEntry = selectedEntry, selectedItemType == .entry {
                    GeometryReader { geometry in
                        pieChartView(journalEntry: selectedEntry.content!)
                            .frame(width: min(geometry.size.width - 40, 550), // Adjust size as needed
                                   height: min(geometry.size.width - 40, 550)) // Adjust size as needed
                            .padding(.horizontal, 20) // Adjustable padding
                    }
                } else {
                    GeometryReader { geometry in
                        weekPieChartView(emotions: moodManager.globalWeekData)
                            .frame(width: min(geometry.size.width - 40, 550),
                                   height: min(geometry.size.width - 40, 550))
                            .padding(.horizontal, 20)
                    }
                }
                Spacer()
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
                        .font(.title2)
                        .padding()
                    Image(systemName: "chart.pie.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
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
                          .font(.title2)
                          .padding()
                      Image(systemName: "chart.pie.fill")
                          .font(.largeTitle)
                          .foregroundColor(.blue)
  //                    .foregroundStyle(.secondary)
                  }
                .position(x: frame.midX, y: frame.midY)
              }
            }
        }
    }
    
    


    




}

