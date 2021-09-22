//
//  UIImageView+Extensions.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation
import UIKit

extension UIImageView {
    /// Load an image from an url and set it in the image view
    /// - Parameters:
    ///   - url: The url of the image
    ///   - completion: The completion block if needed
    func load(url: URL, completion: (()->Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?()
                    }
                }else {
                    DispatchQueue.main.async {
                        self?.image = UIImage(named: "placeholder")
                        completion?()
                    }
                }
            }else {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "placeholder")
                    completion?()
                }
                
            }
        }
    }
    
    /// Enable zooming on an image
    func enableZoom() {
      let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
      isUserInteractionEnabled = true
      addGestureRecognizer(pinchGesture)
    }
    
    /// Called when we start to pinch to zoom
    /// - Parameter sender: The pinch gesture
    @objc private func startZooming(_ sender: UIPinchGestureRecognizer) {
      let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
      guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
      sender.view?.transform = scale
      sender.scale = 1
    }
}
