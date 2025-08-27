//
//  APIClient.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/20/25.
//

import Foundation

// MARK: - APIServiceProtocol
protocol APIServiceProtocol {
    func fetchImages() async throws -> [ImageDTO]
} // APIServiceProtocol

// MARK: - APIService
final class APIService: APIServiceProtocol {
    private let baseURL: URL
    private let builder: APIBuilder<[ImageDTO]>
    
    // MARK: - init
    init(baseURL: URL, path: String) {
        self.baseURL = baseURL
        self.builder = APIBuilder(endpoint: Endpoint(path: path))
    } // init
    
    // MARK: - fetchImages
    func fetchImages() async throws -> [ImageDTO] {
        try await builder.request(baseURL: baseURL)
    } // fetchImages
    
} // APIService
