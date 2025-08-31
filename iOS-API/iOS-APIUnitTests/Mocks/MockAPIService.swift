//
//  MockAPIService.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/29/25.
//

@testable import iOS_API
import Foundation

// MARK: - MockAPIService
final class MockAPIService: APIServiceProtocol {
    
    var fetchImagesResult: Result<[ImageDTO], Error>?
    var updateImageNameResult: Result<MessageDTO, Error>?

    // MARK: - fetchImages
    func fetchImages() async throws -> [ImageDTO] {
        if let result = fetchImagesResult {
            return try result.get()
        }
        throw APIError.unknown
    } // fetchImages

    // MARK: - updateImageName
    func updateImageName(id: String, newName: String) async throws -> MessageDTO {
        if let result = updateImageNameResult {
            return try result.get()
        }
        throw APIError.unknown
    } // updateImageName

    // MARK: - request
    func request<T>(endpoint: Endpoint<T>, baseURL: URL, session: URLSession) async throws -> T where T : Decodable {
        throw APIError.unknown
    } // request
    
} // MockAPIService
