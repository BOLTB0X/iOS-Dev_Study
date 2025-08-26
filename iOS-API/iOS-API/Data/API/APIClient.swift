//
//  APIClient.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/20/25.
//

import Foundation

// MARK: - APIClient
final class APIClient<Response: Decodable>: APIBuilder {
    
    var url: URL
    var method: String
    var body: Data?
    var parameters: [String: Any]?
    
    // MARK: - init
    init(url: URL, method: String = "GET",
         body: Data? = nil, parameters: [String: Any]? = nil) {
        self.url = url
        self.method = method
        self.body = body
        self.parameters = parameters
    } // init
    
    // MARK: - request
    func request() async throws -> Response {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown
            }
            
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
        }
    } // decode
    
} // APIClient
