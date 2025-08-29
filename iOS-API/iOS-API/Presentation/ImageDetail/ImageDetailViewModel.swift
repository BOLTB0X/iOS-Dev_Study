//
//  ImageDetailViewModel.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/28/25.
//

import Foundation
import Combine

// MARK: - ImageDetailViewModel
final class ImageDetailViewModel {
    private let image: ImageEntity
    private let useCase: UpdateFileNameUseCase
    
    @Published private(set) var filename: String
    let didUpdate = PassthroughSubject<ImageEntity, Never>()
    
    // MARK: - init
    init(image: ImageEntity,
         useCase: UpdateFileNameUseCase) {
        self.image = image
        self.useCase = useCase
        self.filename = image.filename.replacingOccurrences(of: ".png", with: "")
    } // init
    
    // MARK: - updateImage
    func updateImage(to newName: String) async throws {
        let updated = try await useCase.execute(id: image.id, newName: newName)
        print(updated)
        
        let updatedEntity = ImageEntity(id: image.id,
                                        filename: newName + ".png",
                                        prompt: image.prompt,
                                        imageURL: image.imageURL.replacingOccurrences(of: image.filename, with: newName + ".png"),
                                        timestamp: image.timestamp)
        didUpdate.send(updatedEntity)
    } // updateImage
    
} // ImageDetailViewModel

