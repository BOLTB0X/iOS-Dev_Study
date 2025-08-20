//
//  UIViewControllerRepresentable.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/20/25.
//

import UIKit
import SwiftUI

extension ImageListViewController {
    private struct Preview: UIViewControllerRepresentable {
        let vc: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return vc
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    } // Preview
    
    func toPreview() -> some View {
        Preview(vc: self)
    } // toPreview
} // ImageListViewController
