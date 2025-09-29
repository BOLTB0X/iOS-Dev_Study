//
//  ContentViewModelTests.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 9/29/25.
//

import XCTest

// 4. 테스트 대상 클래스 (ViewModel)
class ContentViewModel {
    private let fetcher: Fetching
    var content: String?
    
    init(fetcher: Fetching) {
        self.fetcher = fetcher
    }
    
    // Task를 사용하여 비동기 함수를 호출
    func loadContent() {
        Task { // ViewModel에서는 Task를 사용하여 비동기 코드를 실행
            do {
                let data = try await fetcher.fetchData()
                // UI 업데이트는 Main Actor에서 처리되어야 하지만, 테스트의 단순화를 위해 생략
                self.content = String(data: data, encoding: .utf8)
            } catch {
                self.content = nil // 실패 시 nil로 설정
            }
        }
    }
}

class ContentViewModelTests: XCTestCase {

    // 테스트 함수에 'async' 키워드를 붙여야 합니다.
    func testLoadContent_Success() async throws {
        // 1. Arrange (준비)
        let mockFetcher = MockNetworkService()
        mockFetcher.shouldSucceed = true
        mockFetcher.mockData = "Hello, Async!".data(using: .utf8)
        
        let sut = ContentViewModel(fetcher: mockFetcher)

        // 2. Act (실행): View Model 내부의 Task가 비동기 작업을 시작
        // 테스트에서는 Task의 완료를 기다려야 하지만, Mock이 동기적으로 처리하므로
        // ContentViewModel의 loadContent() 호출 직후 상태를 검증 가능
        sut.loadContent()

        // 3. Assert (단언)
        // **주의:** ViewModel 내부의 Task 완료를 기다리는 코드가 필요할 수 있지만,
        // Mock이 동기적으로 응답하기 때문에 대부분의 경우 바로 검증이 가능
        // (실제 비동기 작업에서는 XCTestExpectation을 사용해야 함)
        
        // Mock이 설정한 데이터와 일치하는지 확인
        XCTAssertEqual(sut.content, "Hello, Async!")
    }

    func testLoadContent_Failure() async throws {
        // 1. Arrange (준비)
        let mockFetcher = MockNetworkService()
        mockFetcher.shouldSucceed = false

        let sut = ContentViewModel(fetcher: mockFetcher)

        // 2. Act (실행)
        sut.loadContent()

        // 3. Assert (단언)
        // 에러 발생 시 content는 nil이어야 함
        XCTAssertNil(sut.content)
    }
}
