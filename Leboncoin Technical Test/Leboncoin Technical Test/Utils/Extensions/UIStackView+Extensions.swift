//
//  UIStackView+Extensions.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation
import UIKit

extension UIStackView {
    /// Add an UIView inside stackview to simulate background color
    /// - Parameter color: The color of the view
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
