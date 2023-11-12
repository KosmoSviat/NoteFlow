//
//  NoteEntity+CoreDataProperties.swift
//  NoteFlow
//
//  Created by Sviatoslav Samoilov on 22.08.2023.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var imageUrl: URL?

}

extension NoteEntity : Identifiable {

}
