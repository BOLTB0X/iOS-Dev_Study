//
//  ContentViewModelTests.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 9/29/25.
//

import XCTest

// MARK: - ContentViewModel
class ContentViewModel {
    private let fetcher: Fetching
    var content: String?
    
    init(fetcher: Fetching) {
        self.fetcher = fetcher
    }
    
    func loadContent() {
        Task {
            do {
                let data = try await fetcher.fetchData()
                self.content = String(data: data, encoding: .utf8)
            } catch {
                self.content = nil
            }
        }
    }
} // ContentViewModel

// MARK: - ContentViewModelTests
class ContentViewModelTests: XCTestCase {

    func testLoadContent_Success() async throws {
        let mockFetcher = MockNetworkService()
        mockFetcher.shouldSucceed = true
        mockFetcher.mockData = "Hello, Async!".data(using: .utf8)
        
        let sut = ContentViewModel(fetcher: mockFetcher)

        sut.loadContent()

        XCTAssertEqual(sut.content, "Hello, Async!")
    }

    func testLoadContent_Failure() async throws {
        let mockFetcher = MockNetworkService()
        mockFetcher.shouldSucceed = false

        let sut = ContentViewModel(fetcher: mockFetcher)

        sut.loadContent()

        XCTAssertNil(sut.content)
    }
} // ContentViewModelTests
