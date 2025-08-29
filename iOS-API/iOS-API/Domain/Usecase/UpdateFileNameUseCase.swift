//
//  UpdateFileNameUseCase.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/28/25.
//

import Foundation

// MARK: - UpdateFileNameUseCase
final class UpdateFileNameUseCase {
    private let repository: ImageRepositoryProtocol
    
    // MARK: - init
    init(repository: ImageRepositoryProtocol) {
        self.repository = repository
    } // init
    
    // MARK: - execute
    func execute(id: String,
                 newName: String) async throws -> String {
        try await repository.updateImageName(id: id, newName: newName)
    } // execute
    
} // UpdateFileNameUseCase
