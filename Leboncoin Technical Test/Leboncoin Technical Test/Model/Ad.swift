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
    
    /// Returns the price formatted
    /// - Returns: The price formatted
    func priceFormat() -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "fr")
        let priceString = nf.string(from: NSNumber(value: price))
        return "\(priceString ?? "") \(Constants.Format.currency)"
    }
    
    func dateFormat() -> String {
        guard let creationDateAsDate = creationDateAsDate() else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM yyyy à hh:mm"
        dateFormatter.locale = Locale(identifier: "fr")
        let dateString = dateFormatter.string(from: creationDateAsDate)
        return dateString.capitalized
    }
    
    /// Sorts an array of ad correctly
    /// - Parameter ads: The ads to sort
    /// - Returns: The ads sorted
    static func sortAdsByUrgentAndDate(ads: [Ad]) -> [Ad] {
        let sortedAds = ads.sorted(by: {
            if !$1.isUrgent && $0.isUrgent {
                return true
            }else if $1.isUrgent && !$0.isUrgent {
                return false
            }else {
                guard let firstDate = $0.creationDateAsDate(), let secondDate = $1.creationDateAsDate() else {
                    return false
                }
                return firstDate > secondDate
            }
            }
        )
        return sortedAds
    }
}
