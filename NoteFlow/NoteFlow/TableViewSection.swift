//
//  TableViewSection.swift
//  NoteFlow
//
//  Created by Sviatoslav Samoilov on 22.08.2023.
//

import Foundation

protocol TableViewItemProtocol { }

struct TableViewSection {
    var title: String?
    var items: [TableViewItemProtocol]
}
