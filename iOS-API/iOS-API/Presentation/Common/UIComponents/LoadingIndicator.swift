//
//  LoadingIndicator.swift
//  iOS-API
//
//  Created by KyungHeon Lee on 8/29/25.
//  출처: https://ios-development.tistory.com/682

import UIKit

// MARK: - LoadingIndicator
final class LoadingIndicator {
    private static var overlayView: UIView?
    
    // MARK: - show
    static func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow }) else { return }

            // 이미 overlayView 가 있으면 재사용
            if overlayView == nil {
                let overlay = UIView(frame: window.bounds)
                overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)

                let indicator = UIActivityIndicatorView(style: .large)
                indicator.color = .white
                indicator.center = overlay.center
                indicator.startAnimating()

                overlay.addSubview(indicator)
                window.addSubview(overlay)
                overlayView = overlay
            } // if
        }
    } // show

    // MARK: - hide
    static func hide() {
        DispatchQueue.main.async {
            overlayView?.removeFromSuperview()
            overlayView = nil
        }
    } // hide
}
