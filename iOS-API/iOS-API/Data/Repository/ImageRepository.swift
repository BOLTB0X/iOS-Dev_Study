//
//  ImageRepository.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - ImageRepositoryProtocol
protocol ImageRepositoryProtocol {
    func fetchImages() async throws -> [ImageEntity]
    func updateImageName(id: String, newName: String) async throws -> FileNameEntity
} // ImageRepositoryProtocol

// MARK: - ImageRepository
final class ImageRepository: ImageRepositoryProtocol {
    
    private let baseURL: String
    private let apiService: APIServiceProtocol
    
    // MARK: - init
    init() {
        self.baseURL = Bundle.main.apiURL!
        self.apiService = APIService(baseURL: URL(string:baseURL)!)
    } // init
    
} // ImageRepository

// MARK: - ImageRepository Methods
extension ImageRepository {
    
    
    // MARK: - fetchImages
    func fetchImages() async throws -> [ImageEntity] {
        let dtos = try await apiService.fetchImages()
        return dtos.map {
            $0.toEntity(baseURL: baseURL)
        }
    } // fetchImages
    
    // MARK: - updateImageName
    func updateImageName(id: String,
                         newName: String) async throws -> FileNameEntity {
        let dto = try await apiService.updateImageName(id: id, newName: newName)
        return dto.toEntity()
    } // updateImageName
    
    
}
