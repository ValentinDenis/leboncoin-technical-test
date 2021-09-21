//
//  UIImageView+Extensions.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation
import UIKit

extension UIImageView {
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
}
