//
//  EndPoint.swift
//  TestApp
//
//  Created by Сергей Мирошниченко on 18.09.2020.
//  Copyright © 2020 7rlines. All rights reserved.
//

import Foundation

//typealias Completion<T> = (T) -> Void
//public typealias HTTPHeaders = [String:String]
//
//protocol EndPointType {
//    var baseURL: URL { get }
//    var path: String { get }
//    var headers: HTTPHeaders { get }
//}
//
//public enum EndPoint {
//    case categories
//}
//
//extension EndPoint: EndPointType {
//    var headers: HTTPHeaders {
//        let headers = [
//            "x-rapidapi-host": "the-cocktail-db.p.rapidapi.com",
//            "x-rapidapi-key": "a0017eaaedmshfd55baf692ef617p111fdejsna896695148dd"
//        ]
//        return headers
//    }
//    
//    private var urlStr: String {
//        return "https://the-cocktail-db.p.rapidapi.com/"
//    }
//    
//    var baseURL: URL {
//        guard let url = URL(string: urlStr)
//            else { fatalError("baseURL could not be configured.")}
//        return url
//    }
//    
//    var path: String {
//        switch self {
//        case .categories:
//            return "list.php?c=list"
//        default:
//            return ""
//        }
//    }
//}
