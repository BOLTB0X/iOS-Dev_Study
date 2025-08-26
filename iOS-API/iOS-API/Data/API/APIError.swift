//
//  APIError.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation

// MARK: - APIError
enum APIError: Error {
    case invalidURL
    case decodingFailed
    case unknown
    case networkError(Error)
    case invalidResponse(Int) // HTTP 상태 코드
} // APIError

// MARK: - LocalizedError
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL이 유효하지 않음"
        case .decodingFailed:
            return "데이터 디코딩에 실패"
        case .unknown:
            return "알 수 없는 오류가 발생"
        case .networkError(let error):
            return "네트워크 오류: \(error.localizedDescription)"
        case .invalidResponse(let statusCode):
            return "잘못된 응답 (HTTP: \(statusCode))"
        }
    }
} // LocalizedError
