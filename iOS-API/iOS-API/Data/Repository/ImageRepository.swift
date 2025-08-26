//
//  ImageRepository.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - ImageRepository
protocol ImageRepository {
    func fetchImages() async throws -> [ImageEntity]
} // ImageRepositoryProtocol

// MARK: - ImageRepository
final class ImageRepositoryImpl: ImageRepository {
    
    private let baseURL = Bundle.main.apiURL!
    private let apiURL: URL
    private lazy var client = APIClient<[ImageDTO]>(url: apiURL)
    
    init() {
        self.apiURL = URL(string:baseURL)!.appendingPathComponent("read")
    }
    
    // MARK: - fetchImages
    func fetchImages() async throws -> [ImageEntity] {
        let dtos = try await client.request()
        return dtos.map {
            $0.toEntity(baseURL: baseURL)
        }
    } // fetchImages
    
} // ImageRepository
