//
//  MovieEndPoint.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 10.10.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case prod
    case stage
}

public enum MovieAPI {
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
}

extension MovieAPI: EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .prod:
            return "https://api.themoviedb.org/3/movie/"
        default:
            return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("Base URL could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .url,
                                      urlParameters: ["page": page,
                                                      "api_key": NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
