//
//  ImageUrl.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

struct ImageUrl: Codable {
    let small: String?
    let thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case small = "small"
        case thumb = "thumb"
    }
}
