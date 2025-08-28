//
//  FilenameDTO.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/28/25.
//

import Foundation

// MARK: - FileNameDTO
struct FileNameDTO: Codable {
    let id: String
    let filename: String

    enum CodingKeys: String, CodingKey {
        case id, filename
    }
    
} // FileNameDTO

// MARK: - Mapper
extension FileNameDTO {
    // MARK: - toEntity
    func toEntity() -> FileNameEntity {
        FileNameEntity(id: id, filename: filename)
    } // toEntity
    
} // Mapper
