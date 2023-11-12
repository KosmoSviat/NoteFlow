//
//  FileManagerPersistent.swift
//  NoteFlow
//
//  Created by Sviatoslav Samoilov on 22.08.2023.
//

import UIKit

final class FileManagerPersistent {
    static func save(_ image: UIImage, with name: String) -> URL? {
        let data = image.jpegData(compressionQuality: 1)
        let url = getDocumentDirectory().appendingPathComponent(name)
        do {
            try data?.write(to: url)
            return url
        } catch {
            print("Save image error: \(error)")
            return nil
        }
    }
    
    static func read(from url: URL) -> UIImage? {
        UIImage(contentsOfFile: url.path)
    }
    
    static func delete(from url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Delete image error: \(error)")
        }
    }
    
    private static func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
