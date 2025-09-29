//
//  MockNetworkService.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 9/29/25.
//

import Foundation

// 1. Protocol 정의 (Async/Await)
protocol Fetching {
    // 클로저 대신, 비동기(async)로 동작하며 에러를 던질 수 있는(throws) 함수로 변경
    func fetchData() async throws -> Data
}

class MockNetworkService: Fetching {
    var shouldSucceed = true
    var mockData: Data? = "Hello, Async!".data(using: .utf8)

    // async throws 함수로 변경
    func fetchData() async throws -> Data {
        print("Mock Network Service 호출됨 (Async)")
        
        if shouldSucceed, let data = mockData {
            // 성공 시 바로 데이터를 반환 (return)
            return data
        } else {
            // 실패 시 바로 에러를 던짐 (throw)
            throw NSError(domain: "MockError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mocking 실패"])
        }
    }
}
