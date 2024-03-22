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

enum ThumbnailType: String, CaseIterable {
    case date = "Date"
    case title = "Title"
    case image = "Image"
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
    //State variable for setting the thumbnail type
    @State private var thumbnailType: ThumbnailType = .date
    
    var body: some View {
        NavigationView {
            VStack {
                // Show either List or Grid based on selection
                if selectedLayout == .list {
                    DiaryEntryListView(thumbnailType: $thumbnailType, entries: entries)
                } else {
                    DiaryEntryGridView(thumbnailType: $thumbnailType, entries: entries)
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
struct DiaryEntryListView: View {
    @Binding var thumbnailType: ThumbnailType
    let entries: [DiaryEntry]
    
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
                            Text(entry.text)
                                .font(.headline)
                        case .image:
                            // Placeholder text since there's no image data in DiaryEntry struct
                            Text("No Image")
                                .font(.headline)
                        }
                        //Displays the text of the entry
//                        Text(entry.text)
//                            .font(.body)
//                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}





//Struct for displaying entries in a grid/gallery format
struct DiaryEntryGridView: View {
    @Binding var thumbnailType: ThumbnailType
    let entries: [DiaryEntry]
    
    var body: some View {
        NavigationView {
            ScrollView {
                //LazyVGrid makes columns where you can adjust the width
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                    //iterates over the amount of entries
                    ForEach(entries, id: \.id) { entry in
                        //calling secondary grid struct
                        DiaryEntryGridCell(entry: entry, thumbnailType: $thumbnailType)
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
    @Binding var thumbnailType: ThumbnailType
    
    var body: some View {
        VStack(alignment: .leading) {
            // Use thumbnailType directly or access its properties/methods
            switch thumbnailType {
            case .date:
                Text("\(entry.date, formatter: DateFormatter.date)")
                    .font(.headline)
            case .title:
                Text(entry.text)
                    .font(.headline)
            case .image:
                // Placeholder text since there's no image data in DiaryEntry struct
                Text("No Image")
                    .font(.headline)
            }
            //Displays the text of the entry
//                        Text(entry.text)
//                            .font(.body)
//                            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}


#Preview {
    JournalEntriesView()
}
