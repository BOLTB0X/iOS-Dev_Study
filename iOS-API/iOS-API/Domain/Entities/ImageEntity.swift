//
//  GenerativeImage.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/20/25.
//

import Foundation

// MARK: - ImageEntity
struct ImageEntity {
    let id: String
    var filename: String
    let prompt: String
    let imageURL: String
    let timestamp: String
    
    init(id: String,
         filename: String,
         prompt: String,
         imageURL: String,
         timestamp: String) {
        self.id = id
        self.filename = filename
        self.prompt = prompt
        self.imageURL = imageURL
        self.timestamp = timestamp
    } // init
    
} // ImageEntity
