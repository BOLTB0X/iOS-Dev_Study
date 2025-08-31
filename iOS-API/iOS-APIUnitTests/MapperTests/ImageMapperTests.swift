//
//  ImageMapperTests.swift
//  iOS-APIUnitTests
//
//  Created by KyungHeon Lee on 8/29/25.
//

import XCTest
@testable import iOS_API

final class ImageMapperTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - testDTOToEntity
    func testDTOToEntity() {
        // given
        let dto = ImageDTO(
            id: "123",
            filename: "test.png",
            prompt: "a cute cat",
            imageURL: "images/test.png",
            timestamp: "2025-08-29"
        )
        
        let baseURL = "https://example.com"
        
        // when
        let entity = dto.toEntity(baseURL: baseURL)
        
        // then
        XCTAssertEqual(entity.id, "123")
        XCTAssertEqual(entity.filename, "test.png")
        XCTAssertEqual(entity.prompt, "a cute cat")
        XCTAssertEqual(entity.timestamp, "2025-08-29")
        XCTAssertEqual(entity.imageURL, "https://example.com/images/test.png")
    } // testDTOToEntity
    
} // ImageMapperTests
