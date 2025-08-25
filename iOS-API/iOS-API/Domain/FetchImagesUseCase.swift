//
//  FetchImagesUseCase.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - FetchImagesUseCase
final class FetchImagesUseCase {
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    // MARK: - execute
    func execute(limit: Int = 20) async throws -> [ImageEntity] {
        let images = try await repository.fetchImages()
        return images
    } // execute
} // FetchImagesUseCase

