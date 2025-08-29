//
//  APIClient.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/20/25.
//

import Foundation

// MARK: - APIServiceProtocol
protocol APIServiceProtocol {
    func request<T: Decodable>(
        endpoint: Endpoint<T>,
        baseURL: URL,
        session: URLSession) async throws -> T

    func fetchImages() async throws -> [ImageDTO]
    func updateImageName(id: String, newName: String) async throws -> MessageDTO
} // APIServiceProtocol

// MARK: - APIServiceProtocol Methods
extension APIServiceProtocol {
    
    
    // MARK: - request
    func request<T: Decodable>(
        endpoint: Endpoint<T>,
        baseURL: URL,
        session: URLSession
    ) async throws -> T {
        let builder = APIBuilder(endpoint: endpoint)
        return try await builder.request(baseURL: baseURL, session: session)
    } // request
    
    
} // APIServiceProtocol Methods

// MARK: - APIService
final class APIService: APIServiceProtocol {
    private let baseURL: URL
    private let session: URLSession

    // MARK: - init
    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    } // init

} // APIService

// MARK: - APIService Methods
extension APIService {
    
    
    // MARK: - fetchImages
    func fetchImages() async throws -> [ImageDTO] {
        try await request(
            endpoint: Endpoint<[ImageDTO]>(path: "read", method: .get),
            baseURL: baseURL,
            session: session
        )
    } // fetchImages
    
    // MARK: - updateImageName
    func updateImageName(id: String, newName: String) async throws -> MessageDTO {

        let params = "filename=\(newName)"
        let body = params.data(using: .utf8)
        
        let endpoint = Endpoint<MessageDTO>(path: "update/\(id)",
                                             method: .put,
                                             headers: ["Content-Type": "application/x-www-form-urlencoded"],
                                             body: body)
        
        return try await request(
            endpoint: endpoint,
            baseURL: baseURL,
            session: session
        )
    } // updateImageName
    
    
} // APIService Methods
