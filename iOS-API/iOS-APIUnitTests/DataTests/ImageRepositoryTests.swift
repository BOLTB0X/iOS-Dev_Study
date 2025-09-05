//
//  ImageRepositoryTests.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 9/4/25.
//

import XCTest
@testable import iOS_API

// MARK: - ImageRepositoryTests
final class ImageRepositoryTests: XCTestCase {
    
    private var mockAPIService: MockAPIService!
    private var repository: ImageRepository!
    
    // MARK: - setUp / tearDown
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockAPIService = MockAPIService()
        repository = ImageRepository(baseURL: "https://example.com", apiService: mockAPIService)
    }
    
    override func tearDownWithError() throws {
        mockAPIService = nil
        repository = nil
        try super.tearDownWithError()
    }
    
    
    // MARK: - fetchImages
    // ...
    
    // MARK: - testFetchImagesFailure
    func testFetchImagesFailure() async {
        // given
        mockAPIService.fetchImagesResult = .failure(APIError.decodingFailed)
        
        // when & then
        do {
            _ = try await repository.fetchImages()
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    } // testFetchImagesFailure
    
    // MARK: - testFetchImagesSuccess
    func testFetchImagesSuccess() async throws {
        // given
        let dto = ImageDTO(
            id: "1",
            filename: "dog.png",
            prompt: "great dog",
            imageURL: "images/dog.png",
            timestamp: "2025-08-29"
        )
        mockAPIService.fetchImagesResult = .success([dto])
        
        // when
        let entities = try await repository.fetchImages()
        
        // then
        XCTAssertEqual(entities.count, 1)
        XCTAssertEqual(entities.first?.filename, "dog.png")
        XCTAssertEqual(entities.first?.imageURL, "https://B0X.com/images/cat.png")
    } // testFetchImagesSuccess
    
    
    // MARK: - updateImageName
    // ...
    
    // MARK: - testUpdateImageNameFailure
    func testUpdateImageNameFailure() async {
        // given
        mockAPIService.updateImageNameResult = .failure(APIError.networkError(NSError()))
        
        // when & then
        do {
            _ = try await repository.updateImageName(id: "1", newName: "new.png")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    } // testUpdateImageNameFailure
    
    // MARK: - testUpdateImageNameSuccess
    func testUpdateImageNameSuccess() async throws {
        // given
        let dto = MessageDTO(message: "Updated successfully")
        mockAPIService.updateImageNameResult = .success(dto)
        
        // when
        let message = try await repository.updateImageName(id: "1", newName: "new.png")
        
        // then
        XCTAssertEqual(message, "Updated successfully")
    } // testUpdateImageNameSuccess
    
} // ImageRepositoryTests
