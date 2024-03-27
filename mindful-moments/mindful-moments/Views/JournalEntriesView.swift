//
//  JournalEntriesView.swift
//  mindful-moments
//
//  Created by Bryan Murphy on 3/15/24.
//

import SwiftUI


//represents a single entry
//Identifiable makes it so each entry has a unique identifier for each instance
struct JournalEntry: Identifiable {
    let id: UUID // Unique identifier for each entry
    let date: Date
    let name: String
    let content: String
}

enum ThumbnailType: String, CaseIterable {
    case date = "Date"
    case title = "Title"
//    case image = "Image"
}

//sample data for two entries
let entries: [JournalEntry] = [
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 1), name: "Morning Reflection", content: "Started the day with a cup of coffee and some deep breathing exercises. Feeling energized and ready to tackle the day ahead."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 2), name: "Productive Workday", content: "Managed to complete all tasks on my to-do list today. Celebrating this small victory with some time for self-care in the evening."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 3), name: "Gratitude Journal", content: "Reflecting on the things I'm grateful for today: family, friends, and the opportunity to pursue my passions."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 4), name: "Creative Inspiration", content: "Spent the afternoon sketching in the park. Nature always seems to spark new ideas and creativity within me."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 5), name: "Personal Growth", content: "Journaling about recent challenges and how they've helped me grow as a person. Embracing the process of continuous improvement."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 6), name: "Wellness Check-In", content: "Taking a moment to assess my physical and mental well-being. Prioritizing self-care activities to maintain balance."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 7), name: "Reflecting on Achievements", content: "Looking back on past accomplishments and setting new goals for the future. Excited about what lies ahead."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 8), name: "Peaceful Evening", content: "Enjoying a quiet evening at home with a good book and a warm cup of tea. Finding solace in simple pleasures."),
    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400 * 9), name: "Mindfulness Practice", content: "Engaging in mindfulness meditation.")
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
        case calendar = "Calendar"
        case grid = "Grid"
    }
    
    //State variable that tracks the selected layout style
    @State private var selectedLayout: LayoutType = .list
    //State variable for setting the thumbnail type
    @State private var thumbnailType: ThumbnailType = .date
    
    var body: some View {
        NavigationView {
            VStack {
                // Show either List or Grid based on selection
                if selectedLayout == .list {
                    JournalEntryListView(thumbnailType: $thumbnailType, entries: entries)
                } 
                else if selectedLayout == .calendar{
                    JournalEntryCalendarView(entries: entries)
                }
                else {
                    JournalEntryGridView(thumbnailType: $thumbnailType, entries: entries)
                }
            }
            .padding(.top, 1)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("Journal Entries")
                            .font(.title)
                            .fontWeight(.bold)
                        Menu {
                            //Adds section header for menu
                            Section(header: Text("Appearance Settings")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)) {
                                //displays each layout from the layoutType
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
                            }
                            // Add options from the ThumbnailType enum
                            Divider()
                            Section(header: Text("Thumbnail Settings")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.black)) {
                                ForEach(ThumbnailType.allCases, id: \.self) { thumbnailType in
                                    Button(action: {
                                        self.thumbnailType = thumbnailType
                                    }) {
                                        HStack {
                                            Text(thumbnailType.rawValue) // Use rawValue instead of description
                                            if thumbnailType == self.thumbnailType {
                                                Spacer()
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.blue)
                                            }
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

//Calendar view
struct JournalEntryCalendarView: View {
    @State private var selectedDate = Date()
    let entries: [JournalEntry]

    var body: some View {
        VStack {
            // Date Picker
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(CalendarDatePickerStyle(selectedDate: $selectedDate))
                .padding()
            Spacer()
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}

struct CalendarDatePickerStyle: DatePickerStyle {
    @Binding var selectedDate: Date

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle()) // Display as calendar
        }
    }
}

//struct for diary entry list view
//allows thumbnails
struct JournalEntryListView: View {
    @Binding var thumbnailType: ThumbnailType
    let entries: [JournalEntry]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(entries, id: \.id) { entry in
                    NavigationLink(destination: JournalEntryDetailView(entry: entry)) {
                        VStack(alignment: .leading) {
                            // Use thumbnailType directly or access its properties/methods
                            switch thumbnailType {
                            case .date:
                                Text("\(entry.date, formatter: DateFormatter.date)")
                                    .font(.headline)
                            case .title:
                                Text(entry.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
        }
    }
}





//Struct for displaying entries in a grid/gallery format
struct JournalEntryGridView: View {
    @Binding var thumbnailType: ThumbnailType
    let entries: [JournalEntry]
    
    var body: some View {
        NavigationView {
            ScrollView {
                //LazyVGrid makes columns where you can adjust the width
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                    //iterates over the amount of entries
                    ForEach(entries, id: \.id) { entry in
                        //calling secondary grid struct
                        NavigationLink(destination: JournalEntryDetailView(entry: entry)) {
                            JournalEntryGridCell(entry: entry, thumbnailType: $thumbnailType)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

//Struct to display an entry in the DiaryEntryGridView
struct JournalEntryGridCell: View {
    let entry: JournalEntry
    @Binding var thumbnailType: ThumbnailType
    
    var body: some View {
        VStack(alignment: .leading) {
            // Use thumbnailType directly or access its properties/methods
            switch thumbnailType {
            case .date:
                Text("\(entry.date, formatter: DateFormatter.date)")
                    .font(.headline)
            case .title:
                Text(entry.name)
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}

//Struct to display an entry and its contents
struct JournalEntryDetailView: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack {
            Text(entry.name)
                .font(.title)
                .padding()
            Text(entry.content)
                .padding()
            Spacer()
        }
    }
}



#Preview {
    JournalEntriesView()
}
