//
//  NotePersistent.swift
//  NoteFlow
//
//  Created by Sviatoslav Samoilov on 22.08.2023.
//

import CoreData
import Foundation

final class NotePersistent {
    private static let context = AppDelegate.persistentContainer.viewContext
    
    static func save(_ note: Note) {
        var entity: NoteEntity?
        if let ent = getEntity(for: note) {
            entity = ent
        } else {
            guard let description = NSEntityDescription.entity(forEntityName: "NoteEntity", in: context) else { return }
            entity = NoteEntity(entity: description, insertInto: context)
        }
        entity?.title = note.title
        entity?.text = note.description
        entity?.date = note.date
        entity?.imageUrl = note.imageUrl
        
        saveContext()
    }
    
    static func delete(_ note: Note) {
        guard let entity = getEntity(for: note) else { return }
        context.delete(entity)
        saveContext()
    }
    
    static func fetchAll() -> [Note] {
        let request = NoteEntity.fetchRequest()
        do {
            let objects = try context.fetch(request)
            return convert(entities: objects)
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return []
        }
    }
    
    private static func convert(entities: [NoteEntity]) -> [Note] {
        let notes = entities.map {
            Note(title: $0.title ?? "", description: $0.text, date: $0.date ?? Date(), imageUrl: $0.imageUrl, category: nil)
        }
        return notes
    }
    
    private static func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    private static func getEntity(for note: Note) -> NoteEntity? {
        let request = NoteEntity.fetchRequest()
        let predicate = NSPredicate(format: "date = %@", note.date as NSDate)
        request.predicate = predicate
        do {
            let objects = try context.fetch(request)
            return objects.first
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return nil
        }
    }
    
    private static func saveContext() {
        do {
            try context.save()
            postNotification()
        } catch let error {
            debugPrint("Save not error: \(error)")
        }
    }
}
