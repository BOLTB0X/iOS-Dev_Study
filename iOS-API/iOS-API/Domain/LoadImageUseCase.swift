//
//  LoadImageUseCase.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/26/25.
//

import UIKit

// MARK: - LoadImageUseCase
final class LoadImageUseCase {
    private let repository: LoadRepository
    
    init(repository: LoadRepository = LoadRepositoryImpl()) {
        self.repository = repository
    }
    
    // MARK: - execute
    func execute(from url: URL) async throws -> UIImage {
        return try await repository.loadImage(from: url)
    } // execute
    
} // LoadImageUseCase
