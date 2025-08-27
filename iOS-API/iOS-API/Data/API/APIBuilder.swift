//
//  APIBuilder.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - APIBuilderProtocol
protocol APIBuilderProtocol {
    associatedtype Response: Decodable
    
    var endpoint: Endpoint<Response> { get }
    
    func request(baseURL: URL, session: URLSession) async throws -> Response
    func decode(data: Data) throws -> Response
} // APIBuilderProtocol

// MARK: - APIBuilder
final class APIBuilder<Response: Decodable>: APIBuilderProtocol {
    let endpoint: Endpoint<Response>
    
    // MARK: - init
    init(endpoint: Endpoint<Response>) {
        self.endpoint = endpoint
    } // init

    // MARK: - request
    func request(baseURL: URL,
                 session: URLSession = .shared) async throws -> Response {
        let request = try endpoint.makeRequest(baseURL: baseURL)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }

        do {
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse(httpResponse.statusCode)
            }
            
            return try decode(data: data)
        } catch {
            throw APIError.networkError(error)
        } // do-catch
    } // request

    // MARK: - decode
    func decode(data: Data) throws -> Response {
        do {
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            throw APIError.decodingFailed
        } // do - catch
    } // decode
    
} // APIBuilder
