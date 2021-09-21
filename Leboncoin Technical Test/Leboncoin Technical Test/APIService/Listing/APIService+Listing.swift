//
//  APIService+Listing.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

extension APIService {
    //-----------------------------------------------------------------------
    // MARK: - Listing
    //-----------------------------------------------------------------------
    static func fetchAds(completion: @escaping (Result<[Ad], APIError>) -> Void) {
        guard let url = URL(string: Constants.API.baseUrl + APIEndPoint.listing.rawValue) else {
            completion(.failure(.failedCreatingUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        APIService.shared.execute(withRequest: request) { (result: Result<[Ad], APIError>) in
            switch result {
            case .success(let ads):
                //Sort the ads by date
                let sortedAds = Ad.sortAdsByUrgentAndDate(ads: ads)
                completion(.success(sortedAds))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
