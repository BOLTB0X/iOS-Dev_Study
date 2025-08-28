//
//  Endpoint.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/27/25.
//

import Foundation

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put  = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
} // HTTPMethod

// MARK: - Endpoint
struct Endpoint<Response: Decodable> {
    let path: String
    var method: HTTPMethod
    var headers: [String: String]
    var query: [String: String]?
    var body: Data?
    
    // MARK: - init
    init(path: String,
         method: HTTPMethod,
         headers: [String : String] = ["Content-Type": "application/json"],
         query: [String : String]? = nil,
         body: Data? = nil) {
        self.path = path
        self.method = method
        self.headers = headers
        self.query = query
        self.body = body
    } // init

} // Endpoint

// MARK: - Endpoint: Methods
extension Endpoint {
    // MARK: - makeRequest
    func makeRequest(baseURL: URL) throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                       resolvingAgainstBaseURL: false)
        if let query {
            components?.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components?.url else { throw APIError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = body
        
        return request
    } // makeRequest
    
} // Methods
