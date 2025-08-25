//
//  APIBuilder.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - APIBuilder
protocol APIBuilder {
    associatedtype Response: Decodable
    
    var url: URL { get }
    var method: String { get set }
    var body: Data? { get set }
    var parameters: [String: Any]? { get }
    
    func request() async throws -> Response
    func decode(data: Data) throws -> Response
} // APIBuilder
