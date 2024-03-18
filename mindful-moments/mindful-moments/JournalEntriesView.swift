//
//  JournalEntriesView.swift
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
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-86400), text: "Yesterday's entry"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-172800), text: "Two days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-259200), text: "Three days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-345600), text: "Four days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-432000), text: "Five days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-518400), text: "Six days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-604800), text: "A week ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-691200), text: "Eight days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-777600), text: "Nine days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-864000), text: "Ten days ago"),
    DiaryEntry(id: UUID(), date: Date().addingTimeInterval(-950400), text: "Eleven days ago")

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

struct JournalEntriesView: View {
        
    //list of possible layout styles
    enum LayoutType: String, CaseIterable {
        case list = "List"
        case grid = "Grid"
    }
    
    //State variable that tracks the selected layout style
    @State private var selectedLayout: LayoutType = .list
    
    var body: some View {
        NavigationView {
            VStack {
                // Show either List or Grid based on selection
                if selectedLayout == .list {
                    DiaryEntryListView(entries: entries)
                } else {
                    DiaryEntryGridView(entries: entries)
                }
            }
            .padding(.top, 1)
            //allows adding buttons and titles
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("Journal Entries")
                            .font(.title)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Menu {
                            ForEach(LayoutType.allCases, id: \.self) { layout in
                                Button(action: {
                                    self.selectedLayout = layout
                                }) {
                                    //adds check marks on the selected view
                                    HStack {
                                        Text(layout.rawValue)
                                        if layout == selectedLayout {
                                            Spacer()
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundColor(.blue)
                        }
                        .menuStyle(DefaultMenuStyle())
                        Spacer()
                            .frame(width: 110)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
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
//            .navigationTitle("Diary Entries")
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
//            .navigationTitle("Diary Entries")
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
    JournalEntriesView()
}
