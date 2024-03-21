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
    @Environment(\.dismiss) var dismiss
    
    // State variables
    @State private var name: String = {
        let formatter = DateFormatting.mediumDate
        return formatter.string(from: Date())
    }()
    @State private var entryContent: String = ""
    @State private var tags: [String] = ["Tag 1", "Tag 2", "Tag 3"]
    @State private var mediaPaths: [String] = []
    
    var body: some View {
        EntryView(name: name, entryContent: "", tags: [], mediaPaths: [])
    }
}
#Preview {
    NewEntryView()
}
