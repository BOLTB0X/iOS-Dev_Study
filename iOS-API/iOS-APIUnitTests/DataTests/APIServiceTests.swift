//
//  APIServiceTests.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/29/25.
//

import XCTest
@testable import iOS_API

// MARK: - APIServiceTests
final class APIServiceTests: XCTestCase {
    
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
    
    
    // MARK: - testFetchImagesSuccess
    func testFetchImagesSuccess() async throws {
        // given
        let mock = MockAPIService()
        let expected = [
            ImageDTO(id: "1",
                     filename: "test.png",
                     prompt: "prompt",
                     imageURL: "/images/test.png",
                     timestamp: "2025-08-29")
        ]
        mock.fetchImagesResult = .success(expected)
        
        // when
        let result = try await mock.fetchImages()
        
        // then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.filename, "test.png")
    } // testFetchImagesSuccess
    
    
    // MARK: - testFetchImagesFailure
    func testFetchImagesFailure() async {
        // given
        let mock = MockAPIService()
        mock.fetchImagesResult = .failure(APIError.decodingFailed)
        
        do {
            _ = try await mock.fetchImages()
            XCTFail("Should throw error")
        } catch {
            XCTAssertTrue(error is APIError)
        } // do - catch
    } // testFetchImagesFailure
    
    
    // MARK: - testUpdateImageNameSuccess
    func testUpdateImageNameSuccess() async throws {
        // given
        let mock = MockAPIService()
        let expected = MessageDTO(message: "Updated successfully")
        mock.updateImageNameResult = .success(expected)
        
        // when
        let result = try await mock.updateImageName(id: "1", newName: "newName.png")
        
        // then
        XCTAssertEqual(result.message, "Updated successfully")
    } // testUpdateImageNameSuccess
    
    
    func testUpdateImageNameFailure() async throws {
        // given
        let mock = MockAPIService()
        
        mock.updateImageNameResult
    }

    
} // APIServiceTests
