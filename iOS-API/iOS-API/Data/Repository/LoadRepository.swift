//
//  LoadRepository.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/26/25.
//

import UIKit

// MARK: - LoadRepository
protocol LoadRepository {
    func loadImage(from url: URL) async throws -> UIImage
} // LoadRepository

// MARK: - LoadRepositoryImpl
final class LoadRepositoryImpl: LoadRepository {
    private let cache: NSCache<NSURL, UIImage>
    
    init(cache: NSCache<NSURL, UIImage> = NSCache<NSURL, UIImage>()) {
        self.cache = cache
    } // init
    
    // MARK: - loadImage
    func loadImage(from url: URL) async throws -> UIImage {
        if let cached = cache.object(forKey: url as NSURL) {
            return cached
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        
        cache.setObject(image, forKey: url as NSURL)
        return image
    } // loadImage
    
} // LoadRepositoryImpl
