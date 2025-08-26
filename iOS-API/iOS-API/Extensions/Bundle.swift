//
//  Bundle.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/26/25.
//

import Foundation

extension Bundle {
    
    var apiURL: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_URL"] as? String else {
            return nil
        }
        return key
    }
    
}
