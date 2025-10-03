//
//  MockNetworkService.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 9/29/25.
//

import Foundation

protocol Fetching {
    func fetchData() async throws -> Data
} // Fetching

// MARK: - MockNetworkService
class MockNetworkService: Fetching {
    var shouldSucceed = true
    var mockData: Data? = "Hello, Async!".data(using: .utf8)
    
    func fetchData() async throws -> Data {
        print("Mock Network Service 호출됨 (Async)")
        
        if shouldSucceed, let data = mockData {
            return data
        } else {
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mocking 실패"])
        }
    } // fetchData
    
} // MockNetworkService
