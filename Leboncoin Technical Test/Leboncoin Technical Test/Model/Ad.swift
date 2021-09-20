//
//  Ad.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

struct Ad: Codable {
    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Double
    let imagesUrl: ImageUrl
    let creationDate: String
    let isUrgent: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case categoryId = "category_id"
        case title = "title"
        case description = "description"
        case price = "price"
        case imagesUrl = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}

/// Equatable protocol extension
extension Ad: Equatable {
    static func == (lhs: Ad, rhs: Ad) -> Bool {
        return lhs.id == rhs.id
    }
}

/// Comparable Protocol extension
extension Ad: Comparable {
    static func < (lhs: Ad, rhs: Ad) -> Bool {
        if lhs.isUrgent && !rhs.isUrgent { return true}
        guard let lhsDate = lhs.creationDateAsDate() else { return false }
        guard let rhsDate = rhs.creationDateAsDate() else { return false }
        return lhsDate < rhsDate
    }
}

/// Helpers protocol extension
extension Ad {
    /// Returns the creation date as a Date object (for comparison and sorting)
    /// - Returns: The Date object if it could be formatted
    func creationDateAsDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Format.dateFormat
        return formatter.date(from: creationDate)
    }
    
}
