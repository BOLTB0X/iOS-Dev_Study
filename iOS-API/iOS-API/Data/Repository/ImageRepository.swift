//
//  ImageRepository.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - ImageRepository
protocol ImageRepositoryProtocol {
    func fetchImages() async throws -> [ImageEntity]
} // ImageRepositoryProtocol

// MARK: - ImageRepository
final class ImageRepository: ImageRepositoryProtocol {
    
    private let baseURL: String
    private let apiService: APIServiceProtocol
    private let path: String = "read"
    
    // MARK: - init
    init() {
        self.baseURL = Bundle.main.apiURL!
        self.apiService = APIService(baseURL: URL(string:baseURL)!, path: path)
    } // init
    
    // MARK: - fetchImages
    func fetchImages() async throws -> [ImageEntity] {
        let dtos = try await apiService.fetchImages()
        return dtos.map {
            $0.toEntity(baseURL: baseURL)
        }
    } // fetchImages
    
} // ImageRepository
