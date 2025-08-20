//
//  JSONDecoderProvider.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/20/25.
//

import Foundation

// MARK: - JSONDecoder Provider
final class JSONDecoderProvider {
    static let shared: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
} // JSONDecoder
