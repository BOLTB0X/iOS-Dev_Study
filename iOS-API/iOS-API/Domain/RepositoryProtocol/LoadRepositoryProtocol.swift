//
//  LoadRepositoryProtocol.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 9/11/25.
//

import UIKit

// MARK: - LoadRepositoryProtocol
protocol LoadRepositoryProtocol {
    func loadImage(from url: URL) async throws -> UIImage
} // LoadRepositoryProtocol
