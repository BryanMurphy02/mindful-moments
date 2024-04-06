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
        let count: Int
    }
    
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
    func getMoodData() -> [emotionData] {
        let processedData = textProcessor.runProcess()
        return convertToEmotionData(dictionary: processedData)
    }
    
//    struct MoodView: View {
//        let entries = JournalEntries.entries
//        @State private var selectedEntry: JournalEntry? = nil
//        
//        var body: some View {
//            VStack {
//                Menu {
//                    ForEach(entries, id: \.id) { entry in
//                        Button(action: {
//                            selectedEntry = entry
//                        }) {
//                            Text("\(entry.date, formatter: DateFormatter.date)")
//                        }
//                    }
//                } label: {
//                    Text("Select Entry")
//                }
//                .padding()
//                
//                if let selectedEntry = selectedEntry {
//                    Text("Selected Entry: \(selectedEntry.name)")
//                        .padding()
//                }
//            }
//        }
//    }
    struct MoodView: View {
        let entries = JournalEntries.entries
        @State private var selectedEntry: JournalEntry? = nil
        
        var body: some View {
            VStack {
                Menu {
                    ForEach(entries, id: \.id) { entry in
                        Button(action: {
                            selectedEntry = entry
                        }) {
                            Text("\(entry.date, formatter: DateFormatter.date)")
                        }
                    }
                } label: {
                    if let selectedEntry = selectedEntry {
                        Text("\(selectedEntry.date, formatter: DateFormatter.date)")
                    } else {
                        Text("Select Entry")
                    }
                }
                .padding()
                
                pieChartView()
            }
        }
    }




    
    //Main chart view
    struct pieChartView: View{
        let moodManager = moodClass()
        
        var body: some View {
            let data = moodManager.getMoodData()
            // Use Chart view from Charts framework
            Chart(data, id: \.name) { element in
                SectorMark(
                    angle: .value("Sales", element.count),
                    innerRadius: .ratio(0.618),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Name", element.name))
            }
        }
    }

    struct MoodViewsPreviews: PreviewProvider {
        static var previews: some View {
            pieChartView()
        }
    }
}

