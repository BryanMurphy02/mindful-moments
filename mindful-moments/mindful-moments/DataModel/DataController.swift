//
//  DataController.swift
//  SampleCoreData
//
//  Created by Federico on 18/02/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Responsible for preparing a model
    let container = NSPersistentContainer(name: "JournalModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully.")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addEntry(data: EntryData, context: NSManagedObjectContext) {
        let entry = Entry(context: context)
        entry.id = UUID()
        entry.date = Date()
        entry.lastEdited = entry.date
        entry.name = data.name
        entry.content = data.content
        
        save(context: context)
    }
    
    func editEntry(entry: Entry, data: EntryData, context: NSManagedObjectContext) {
        entry.lastEdited = Date()
        entry.name = data.name
        entry.content = data.content
        
        save(context: context)
    }
}
