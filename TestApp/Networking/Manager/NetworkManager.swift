//
//  NetworkManager.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

struct NetworkManager {
    
    static let shared = NetworkManager()
    static let environment = NetworkEnvironment.prod
    static let MovieAPIKey = "2fd452d03ad172264c5bb0a05612db08"
    let router = Router<MovieAPI>()
    
    func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?, _ error: String?) -> ()) {
        router.request(.newMovies(page: page)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handeNetworkResponse(response)
                switch  result {
                case .success:
                    guard let data = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let model = try JSONDecoder().decode(MovieAPIResponse.self, from: data)
                        completion(model.movies, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
    
    fileprivate func handeNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
