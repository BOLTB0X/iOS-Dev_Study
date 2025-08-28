//
//  FilenameEntity.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/28/25.
//

import Foundation

// MARK: - FileNameEntity
struct FileNameEntity {
    let id: String
    let filename: String
    
    init(id: String,
         filename: String) {
        self.id = id
        self.filename = filename
    }
} // FileNameEntity
