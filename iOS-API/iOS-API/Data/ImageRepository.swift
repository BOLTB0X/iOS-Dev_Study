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
    
    private let apiURL = URL(string: Bundle.main.apiURL!)!
    private lazy var client = APIClient<[ImageDTO]>(url: apiURL)
    
    // MARK: - fetchImages
    func fetchImages() async throws -> [ImageEntity] {
        let dtos = try await client.request()
        return dtos.map { $0.toEntity() }
    } // fetchImages
    
} // ImageRepository

extension Bundle {
    
    var apiURL: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            return nil
        }
        return key
    }
    
}
