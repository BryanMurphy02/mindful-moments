/**
 View for new entries
 
 - Authors:
    Nicholas LoPilato, Bryan Murphy
 
 - Version: 0.5
 */


import SwiftUI
import AVKit
import Foundation

struct NewEntryView: View {
    // Managed Object Context for CoreData
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    
    // State variables
    @State private var entryData: EntryData
    
    init() { //init(entry: JournalEntry) {
        _entryData = State(initialValue: EntryData(name: {
                    let formatter = DateFormatting.mediumDate
                    return formatter.string(from: Date())
                }(),
            content: "",
            tags: [],
            mediaFiles: []))
    }
    
    
    var body: some View {
        EntryView(entry: JournalEntry.createEntry(entryData: entryData, in: viewContext))
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
#Preview {
    NewEntryView()
}
