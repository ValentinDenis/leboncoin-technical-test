//
//  Category.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
}

///Helpers for Category
extension Category {
    /// Returns the default category, present all the time
    /// - Returns: The default category
    static func defaultCategory() -> Category {
        return Category(id: -1, name: "Toutes")
    }
}
