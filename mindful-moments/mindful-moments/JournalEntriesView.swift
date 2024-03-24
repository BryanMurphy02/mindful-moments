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
//    JournalEntry(id: UUID(), date: Date(), text: "Today's entry"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-86400), text: "Yesterday's entry"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-172800), text: "Two days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-259200), text: "Three days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-345600), text: "Four days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-432000), text: "Five days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-518400), text: "Six days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-604800), text: "A week ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-691200), text: "Eight days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-777600), text: "Nine days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-864000), text: "Ten days ago"),
//    JournalEntry(id: UUID(), date: Date().addingTimeInterval(-950400), text: "Eleven days ago")

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
    //State variable for setting the thumbnail type
    @State private var thumbnailType: ThumbnailType = .date
    
    var body: some View {
        NavigationView {
            VStack {
                // Show either List or Grid based on selection
                if selectedLayout == .list {
                    JournalEntryListView(thumbnailType: $thumbnailType, entries: entries)
                } else {
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

//struct for diary entry list view
//allows thumbnails
struct JournalEntryListView: View {
    @Binding var thumbnailType: ThumbnailType
    let entries: [JournalEntry]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(entries, id: \.id) { entry in
                    VStack(alignment: .leading) {
                        // Use thumbnailType directly or access its properties/methods
                        switch thumbnailType {
                        case .date:
                            Text("\(entry.date, formatter: DateFormatter.date)")
                                .font(.headline)
                        case .title:
                            Text(entry.content)
                                .font(.headline)
//                        case .image:
//                            // Placeholder text since there's no image data in DiaryEntry struct
//                            Text("No Image")
//                                .font(.headline)
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
                        JournalEntryGridCell(entry: entry, thumbnailType: $thumbnailType)
                    }
                }
                .padding()
            }
//            .navigationTitle("Diary Entries")
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
                Text(entry.content)
                    .font(.headline)
//            case .image:
//                // Placeholder text since there's no image data in DiaryEntry struct
//                Text("No Image")
//                    .font(.headline)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}

struct JournalEntryDetailView: View {
    let entry: JournalEntry
    
    var body: some View {
            Text(entry.content)
                .navigationTitle("Entry Details")
    }
}

struct ClickView: View {
    let entries: [JournalEntry]
    
    var body: some View {
        NavigationView {
            List(entries) { entry in
                NavigationLink(destination: JournalEntryDetailView(entry: entry)) {
                    Text(entry.content)
                }
            }
            .navigationTitle("Diary Entries")
        }
    }
}


#Preview {
    JournalEntriesView()
}
