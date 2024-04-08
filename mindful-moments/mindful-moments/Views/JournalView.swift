//
//  ContentView.swift
//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
// JournalEntriesView

import SwiftUI
import CoreData

enum ThumbnailType: String, CaseIterable {
    case date = "Date"
    case title = "Title"
}

// Deletes food at the current offset
private func deleteFood(offsets: IndexSet, entries: FetchedResults<Entry>, context: NSManagedObjectContext) {
    withAnimation {
        offsets.map { entries[$0] }
        .forEach(context.delete)

        // Saves to our database
        DataController().save(context: context)
    }
}


struct JournalView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var entry: FetchedResults<Entry>
    
    @Environment(\.editMode) var editMode // Add environment property to track edit mode
    
    //list of possible layout styles
    enum LayoutType: String, CaseIterable {
        case list = "List"
        case calendar = "Calendar"
        case grid = "Grid"
    }
    
    //State variable that tracks the selected layout style
    @State private var selectedLayout: LayoutType = .list
    //State variable for setting the thumbnail type
    @State private var thumbnailType: ThumbnailType = .title
    
//    static var entries: [Entry] {Array(entry)}
    
    @State private var showingNewEntryView = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Show either List or Grid based on selection
                if selectedLayout == .list {
                    JournalEntryListView(thumbnailType: $thumbnailType, entries: entry, managedObjContext: managedObjContext)
                        .environment(\.editMode, editMode)
                    
                }
                else if selectedLayout == .calendar{
                    JournalEntryCalendarView(thumbnailType: $thumbnailType, entries: entry, managedObjContext: managedObjContext)
                        .environment(\.editMode, editMode)
                }
                else {
                    JournalEntryGridView(thumbnailType: $thumbnailType, entries: entry)
                        .environment(\.editMode, editMode)

                }
            }
            .padding(.top, 1)
            .navigationTitle("Journal Entries")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewEntryView.toggle()
                    } label: {
                        Label("Add Entry", systemImage: "plus.circle")
                    }
                }
                ToolbarItem() {
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
            }
            .sheet(isPresented: $showingNewEntryView) {
                NewEntryView()
            }
        }
        .navigationViewStyle(.stack) // Removes sidebar on iPad
            
    }
    
    // Deletes entry at the current offset
//    private func deleteEntry(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { entry[$0] }
//            .forEach(managedObjContext.delete)
//
//            // Saves to our database
//            DataController().save(context: managedObjContext)
//        }
//    }
}
// MARK: - Helpers

//helper function to format the date values for visual purposes
extension DateFormatter {
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

// MARK: - Calendar view
struct JournalEntryCalendarView: View {
    @State private var selectedDate = Date()
    @Binding var thumbnailType: ThumbnailType
    @Environment(\.editMode) var editMode // Add environment property to track edit mode
    let entries: FetchedResults<Entry>
    let managedObjContext: NSManagedObjectContext

    var body: some View {
        VStack {
            // Date Picker displayed in calendar view
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(CalendarDatePickerStyle(selectedDate: $selectedDate))
                .padding()
            
            // Journal Entry List View
            JournalEntryListView(thumbnailType: $thumbnailType, entries: entries, managedObjContext: managedObjContext)
                .environment(\.editMode, editMode)
            
            Spacer()
        }
    }
    
//    private var filteredEntries: FetchedResults<Entry> {
//        // Filter entries based on the selected date
//        //return entries.filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }
//        var filteredResults = [Entry]()
//        for entry in entries {
//            if Calendar.current.isDate(entry.date ?? Date(), inSameDayAs: selectedDate) {
//                filteredResults.append(entry)
//            }
//        }
//
//        return FetchRequest(fetchRequest: entries.fetchRequest())
//    }
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

// Define DatePickerCellConfiguration
struct DatePickerCellConfiguration {
    var background: Color
    var foregroundColor: Color
}

//// Conform JournalEntry to Equatable
//extension JournalEntry: Equatable {
//    static func ==(lhs: JournalEntry, rhs: JournalEntry) -> Bool {
//        return lhs.id == rhs.id // Assuming 'id' is unique for each entry
//    }
//}


// MARK: - ListView

//struct for diary entry list view
//allows thumbnails
struct JournalEntryListView: View {
    @Binding var thumbnailType: ThumbnailType
    let entries: FetchedResults<Entry>
    @Environment(\.editMode) var editMode // Add environment property to track edit mode
    let managedObjContext: NSManagedObjectContext
    
    var body: some View {
        List {
            ForEach(entries, id: \.id) { entry in
                NavigationLink(destination: EntryView(entry: entry)) {
                    VStack(alignment: .leading) {
                        // Use thumbnailType directly or access its properties/methods
                        switch thumbnailType {
                        case .date:
                            Text("\(entry.date ?? Date(), formatter: DateFormatter.date)")
                                .font(.headline)
                        case .title:
                            Text(entry.name ?? "Unnamed Entry")
                                .font(.headline)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Fill the entire screen
                
                //            .onDelete(perform: deleteFood(entries: entries, context: context))
            }
            .onDelete(perform: deleteEntry)
            
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    EditButton()
//                }
//            }
        }
        .environment(\.editMode, editMode)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }

    }
    
    private func deleteEntry(offsets: IndexSet) {
           withAnimation {
               offsets.map { entries[$0] }.forEach { entry in
                   managedObjContext.delete(entry) // Delete from shared context
               }
               DataController().save(context: managedObjContext) // Save changes
           }
       }
}

 
// MARK: - GridView

//Struct for displaying entries in a grid/gallery format
struct JournalEntryGridView: View {
    @Binding var thumbnailType: ThumbnailType
    let entries: FetchedResults<Entry>
    @Environment(\.editMode) var editMode // Add environment property to track edit mode
    @State private var isEditMode = false // State variable to track edit mode
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 10) {
                ForEach(entries, id: \.id) { entry in
                    NavigationLink(destination: EntryView(entry: entry)) {
                        VStack {
                            JournalEntryGridCell(entry: entry, thumbnailType: $thumbnailType)
                        }
                    }
                }
                .overlay(
                    // Overlay red dot when in edit mode
                    VStack {
                        HStack {
                            if editMode?.wrappedValue == .active {
                                Button(action: {
                                    // TODO: delete entry
//                                    deleteEntry()
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .offset(x: -10, y: -10) // Adjust position
                                }
                            }
                            Spacer()
                        }
                        
                        Spacer()
                    }
                )
            }
            .padding()
        }
        .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            // Toggle edit mode when EditButton is pressed
                            editMode?.wrappedValue = editMode?.wrappedValue == .inactive ? .active : .inactive
                        }) {
                            EditButton()
                        }
                    }
                }
    }
    
//    private func deleteEntry(offsets: IndexSet) {
//           withAnimation {
//               offsets.map { entries[$0] }.forEach { entry in
//                   managedObjContext.delete(entry) // Delete from shared context
//               }
//               DataController().save(context: managedObjContext) // Save changes
//           }
//       }
}

//Struct to display an entry in the DiaryEntryGridView
struct JournalEntryGridCell: View {
    let entry: Entry
    @Binding var thumbnailType: ThumbnailType
    
    var body: some View {
        VStack(alignment: .leading) {
            switch thumbnailType {
            case .date:
                Text("\(entry.date ?? Date(), formatter: DateFormatter.date)")
                    .font(.headline)
            case .title:
                Text(entry.name ?? "Unnamed Entry")
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
}
