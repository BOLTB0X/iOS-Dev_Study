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
    
    private let fetchImagesUseCase: FetchImagesUseCase
    
    init(fetchImagesUseCase: FetchImagesUseCase) {
        self.fetchImagesUseCase = fetchImagesUseCase
    }
    
    @MainActor
    func fetchImages() async {
        isLoading = true
        
        do {
            let result = try await fetchImagesUseCase.execute()
            images = result
        } catch {
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
} // ImageListViewModel

