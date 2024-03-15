//
//  entriesTest.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 3/15/24.
//

import SwiftUI


//represents a single entry
//Identifiable makes it so each entry has a unique identifier for each instance
struct DiaryEntry: Identifiable {
    let id: UUID // Unique identifier for each entry
    let date: Date
    let text: String
}

//sample data for two entries
let entries: [DiaryEntry] = [
    DiaryEntry(id: UUID(), date: Date(), text: "Today's entry"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-86400), text: "Yesterday's entry")
]

//helper function to format the date values for visual purposes
extension DateFormatter {
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

struct entriesTest: View {
        
    //list of possible layout styles
    enum LayoutType: String, CaseIterable {
        case list = "List"
        case grid = "Grid"
    }
    
    //State variable that tracks the selected layout style
    @State private var selectedLayout: LayoutType = .list
    
    var body: some View {
        VStack {
            Picker("Select Layout", selection: $selectedLayout) {
                ForEach(LayoutType.allCases, id: \.self) { layout in
                    Text(layout.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // Show either List or Grid based on selection
            if selectedLayout == .list {
                DiaryEntryListView(entries: entries)
            } else {
                DiaryEntryGridView(entries: entries)
            }
        }
    }
}

//struct for diary entry list view
struct DiaryEntryListView: View {
    let entries: [DiaryEntry]
    
    var body: some View {
        NavigationView {
            List(entries) { entry in
                VStack(alignment: .leading) {
                    Text("\(entry.date, formatter: DateFormatter.date)")
                        .font(.headline)
                    Text(entry.text)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Diary Entries")
        }
    }
}

//Struct for displaying entries in a grid/gallery format
struct DiaryEntryGridView: View {
    let entries: [DiaryEntry]
    
    var body: some View {
        NavigationView {
            ScrollView {
                //LazyVGrid makes columns where you can adjust the width
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                    //iterates over the amount of entries
                    ForEach(entries) { entry in
                        //calling secondary grid struct
                        DiaryEntryGridCell(entry: entry)
                    }
                }
                .padding()
            }
            .navigationTitle("Diary Entries") // Set navigation title here
        }
    }
}

//Struct to display an entry in the DiaryEntryGridView
struct DiaryEntryGridCell: View {
    let entry: DiaryEntry
    
    var body: some View {
        VStack {
            Text("\(entry.date, formatter: DateFormatter.date)")
                .font(.headline)
            Text(entry.text)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    entriesTest()
}


//struct entriesTest: View {
//    // Sample data for now
//    let entries: [DiaryEntry] = [
//        DiaryEntry(id: UUID(), date: Date(), text: "Today's entry"),
//        DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-86400), text: "Yesterday's entry")
//    ]
//    
//    var body: some View {
//        NavigationView {
//            List(entries) { entry in
//                VStack(alignment: .leading) {
//                    Text("\(entry.date, formatter: DateFormatter.date)")
//                        .font(.headline)
//                    Text(entry.text)
//                        .font(.body)
//                        .foregroundColor(.secondary)
//                }
//            }
//            .navigationTitle("Diary Entries")
//        }
//    }
//}
//
//extension DateFormatter {
//    static let date: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//        return formatter
//    }()
//}
//
//#Preview {
//    entriesTest()
//}
