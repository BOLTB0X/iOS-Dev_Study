//
//  ImageListViewModel.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/25/25.
//

import Foundation
import Combine

// MARK: - ImageListViewModel
final class ImageListViewModel: ObservableObject {
    @Published var images: [ImageEntity] = []
    @Published var isLoading: Bool = false
    
    private let fetchUseCase: FetchImagesUseCase
    
    public let updateUseCase: UpdateFileNameUseCase
    
    init(fetchUseCase: FetchImagesUseCase,
         updateUseCase: UpdateFileNameUseCase) {
        self.fetchUseCase = fetchUseCase
        self.updateUseCase = updateUseCase
    } // init
} // ImageListViewModel

// MARK: - ImageListViewModel Methods
extension ImageListViewModel {
    
    
    // MARK: - fetchImages
    @MainActor
    func fetchImages() async {
        isLoading = true
        
        do {
            let result = try await fetchUseCase.execute()
            images = result
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    } // fetchImages
    
    // MARK: - updateImageInList
    func updateImageInList(_ updated: ImageEntity) {
        if let index = images.firstIndex(where: { $0.id == updated.id }) {
            images[index] = updated
        }
    } // updateImageInList
    
    
} // ImageListViewModel Methods
