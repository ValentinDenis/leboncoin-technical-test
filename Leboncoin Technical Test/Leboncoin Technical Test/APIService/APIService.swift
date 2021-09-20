//
//  APIService.swift
//  Leboncoin Technical Test
//
//  Created by Valentin Denis on 20/09/2021.
//

import Foundation

/// Different possible errors from API Call
enum APIError: Error {
    case failedCreatingUrl
    case noData
    case noStatusCode
    case notFound
    case serverError
    case authorizationFailed
    case parsingFailed
    case sessionError(error: Error)
}

/// Different available endpoints
enum APIEndPoint: String {
    case listing = "listing.json"
    case categories = "categories.json"
}

struct APIService {
    
    //-----------------------------------------------------------------------
    // MARK: - Singleton
    //-----------------------------------------------------------------------
    static let shared = APIService()
    
    //-----------------------------------------------------------------------
    // MARK: - Functions
    //-----------------------------------------------------------------------
    func execute<T : Codable>(withRequest request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        //Log it
        Logger.log(message: "Request with url: \(request.httpMethod ?? "NO METHOD") \(request.url?.absoluteString ?? "")", logLevel: .request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(.noStatusCode))
                return
            }
            
            //Log it
            Logger.log(message: "Response for :\nURL: \(response?.url?.absoluteString ?? "NO URL")\nStatus Code: \(statusCode)", logLevel: .response)
            
            // Check status code
            switch statusCode {
            case 401:
                completion(.failure(.authorizationFailed))
                return
            case 500:
                completion(.failure(.serverError))
                return
            case 404:
                completion(.failure(.notFound))
                return
            default:
                break
            }
            
            // Check Error
            if let error = error {
                //Log it
                Logger.log(message: "Error received : \(error.localizedDescription)", logLevel: .error)
                completion(.failure(.sessionError(error: error)))
                return
            }
            
            // Try parsing
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            let decoder = JSONDecoder()
            do {
                let parsedData = try decoder.decode(T.self, from: data)
                completion(.success(parsedData))
            } catch {
                Logger.log(message: "Error parsing : \(error)", logLevel: .error)
                completion(.failure(.parsingFailed))
            }
        }.resume()
    }
}
