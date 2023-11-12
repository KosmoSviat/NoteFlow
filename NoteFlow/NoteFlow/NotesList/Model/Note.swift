//
//  Note.swift
//  NoteFlow
//
//  Created by Sviatoslav Samoilov on 22.08.2023.
//

import UIKit

struct Note: TableViewItemProtocol {
    let title: String
    let description: String?
    let date: Date
    let imageUrl: URL?
    let category: CategoryNote?
}

enum CategoryNote: String {
    case home = "Home"
    case work = "Work"
    case other = "Other"
    
    var color: UIColor {
        switch self {
        case .home:
            return .systemBlue
        case .work:
            return .black
        case .other:
            return .systemGreen
        }
    }
}
