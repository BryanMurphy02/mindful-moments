//
//  DataController.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/20/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    //let container = NSPersistentContainer(name: "JournalDataModel")
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "JournalDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
        
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                print("Data saved successfully!")
            } catch {
                print("Error saving data: \(error.localizedDescription)")
            }
        }
    }
    
    // Fetch all JournalEntry objects
    func fetchAllEntries() -> [JournalEntry] {
        let fetchRequest: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        do {
            let entries = try viewContext.fetch(fetchRequest)
            return entries
        } catch {
            print("Error fetching entries: \(error.localizedDescription)")
            return []
        }
    }
    
    func addEntry(entryData: EntryData) {
        let entry = JournalEntry.createEntry(entryData: entryData, in: viewContext)
        save()
    }
        
    func editEntry(entry: JournalEntry, entryData: EntryData) {
        entry.update(name: entryData.name, content: entryData.content)
        save()
    }
        
    func deleteEntry(entry: JournalEntry) {
        entry.delete()
        save()
    }
    
    func addTag(name: String) {
        let tag = Tag.createTag(name: name, in: viewContext)
        save()
    }
        
    func deleteTag(tag: Tag) {
        tag.delete()
        save()
    }
        
    func addMediaFile(path: String, type: String, entry: JournalEntry) {
        let mediaFile = MediaFile.createMediaFile(path: path, type: type, belongsToEntry: entry, in: viewContext)
        save()
    }
        
    func deleteMediaFile(mediaFile: MediaFile) {
        mediaFile.delete()
        save()
    }
}
