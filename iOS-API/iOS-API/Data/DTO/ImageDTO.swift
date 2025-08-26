//
//  ImageDTO.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - ImageDTO
struct ImageDTO: Codable {
    let id: String
    let filename: String
    let prompt: String
    let imageURL: String
    let timestamp: String

    enum CodingKeys: String, CodingKey {
        case id, filename, prompt, timestamp
        case imageURL = "image_url"
    }
} // ImageDTO

// MARK: - Mapper
extension ImageDTO {
    func toEntity(baseURL: String) -> ImageEntity {
        return ImageEntity(
            id: id,
            filename: filename,
            prompt: prompt,
            imageURL: baseURL + "/" + imageURL,
            timestamp: timestamp
        )
    } // toEntity
} // Mapper
