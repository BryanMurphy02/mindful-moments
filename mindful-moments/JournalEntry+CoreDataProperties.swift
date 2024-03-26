//
//  JournalEntry+CoreDataProperties.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/24/24.
//
//

import Foundation
import CoreData


extension JournalEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }
    
    // Add a convenience method to create a new JournalEntry
    static func createEntry(entryData: EntryData, in context: NSManagedObjectContext) -> JournalEntry {
        let entry = JournalEntry(context: context)
        entry.entryID = UUID()
        entry.date = Date()
        entry.name = entryData.name
        entry.content = entryData.content
        return entry
    }
        
    // Add a method to update an existing JournalEntry
    func update(name: String, content: String) {
        self.name = name
        self.content = content
        self.lastEdited = Date()
    }
        
    // Add a method to delete the entry
    func delete() {
        managedObjectContext?.delete(self)
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date
    @NSManaged public var entryID: UUID
    @NSManaged public var lastEdited: Date
    @NSManaged public var name: String

}

extension JournalEntry : Identifiable {

}
