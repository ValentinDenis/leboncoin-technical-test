//
//  APIService+Listing.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

extension APIService {
    //-----------------------------------------------------------------------
    // MARK: - Categories
    //-----------------------------------------------------------------------
    static func fetchCategories(completion: @escaping (Result<[Category], APIError>) -> Void) {
        guard let url = URL(string: Constants.API.baseUrl + APIEndPoint.categories.rawValue) else {
            completion(.failure(.failedCreatingUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        APIService.shared.execute(withRequest: request) { (result: Result<[Category], APIError>) in
            completion(result)
        }
    }
}
