//
//  MediaFile+CoreDataProperties.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/24/24.
//
//

import Foundation
import CoreData


extension MediaFile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaFile> {
        return NSFetchRequest<MediaFile>(entityName: "MediaFile")
    }
    
    // Add a convenience method to create a new MediaFile
    static func createMediaFile(path: String, type: String, belongsToEntry: JournalEntry, in context: NSManagedObjectContext) -> MediaFile {
        let mediaFile = MediaFile(context: context)
        mediaFile.mediaID = UUID()
        mediaFile.path = path
        mediaFile.type = type
        mediaFile.belongsToEntry = belongsToEntry
        return mediaFile
    }
        
    // Add a method to delete the media file
    func delete() {
        managedObjectContext?.delete(self)
    }

    @NSManaged public var mediaID: UUID?
    @NSManaged public var path: String?
    @NSManaged public var type: String?
    @NSManaged public var belongsToEntry: JournalEntry?

}

extension MediaFile : Identifiable {

}
