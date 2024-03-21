//
//  DataController.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/20/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "JournalDataModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!! Yippie!")
        } catch {
            print("We could not save the data")
        }
    }
    
    func addEntry(name: String, context: NSManagedObjectContext) {
        let entry = JournalEntry(context: context)
        entry.entryID = UUID()
        entry.date = Date()
        entry.name = name
        
        save(context: context)
    }
    
    func editEntry(entry: JournalEntry, name: String, context: NSManagedObjectContext) {
        entry.lastEdited = Date()
        entry.name = name
        
        save(context: context)
    }
}
