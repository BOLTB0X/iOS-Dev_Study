//
//  ImageRepositoryProtocol.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 9/11/25.
//

import Foundation

// MARK: - ImageRepositoryProtocol
protocol ImageRepositoryProtocol {
    func fetchImages() async throws -> [ImageEntity]
    func updateImageName(id: String, newName: String) async throws -> String
} // ImageRepositoryProtocol
