//
//  Tag+CoreDataProperties.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/24/24.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var name: String
    @NSManaged public var tagID: UUID?
    @NSManaged public var entries: NSSet?

}

// MARK: Generated accessors for entries
extension Tag {
    // Add a convenience method to create a new Tag
    static func createTag(name: String, in context: NSManagedObjectContext) -> Tag {
        let tag = Tag(context: context)
        tag.name = name
        return tag
    }
        
    // Add a method to delete the tag
    func delete() {
        managedObjectContext?.delete(self)
    }

    @objc(addEntriesObject:)
    @NSManaged public func addToEntries(_ value: JournalEntry)

    @objc(removeEntriesObject:)
    @NSManaged public func removeFromEntries(_ value: JournalEntry)

    @objc(addEntries:)
    @NSManaged public func addToEntries(_ values: NSSet)

    @objc(removeEntries:)
    @NSManaged public func removeFromEntries(_ values: NSSet)

}

extension Tag : Identifiable {

}
