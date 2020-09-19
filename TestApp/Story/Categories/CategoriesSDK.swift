////
////  FeedSDK.swift
////  TestApp
////
////  Created by Сергей Мирошниченко on 18.09.2020.
////  Copyright © 2020 7rlines. All rights reserved.
////
//
//import Foundation
//import SDK
//
//public protocol CategoriesRequestable {
//    @discardableResult
//    func fetchCategories(from route: EndPoint, completion: @escaping(Swift.Result<Categories, APIError>) -> Void) -> Cancellable?
//}
//
//extension SDK: CategoriesRequestable {
//    @discardableResult
//    public func fetchCategories(from route: EndPoint, completion: @escaping (Swift.Result<Categories, APIError>) -> Void) -> Cancellable? {
//        let request = buildRequest(path: route.baseURL.appendingPathComponent(route.path),
//                                   method: .get,
//                                   headers: route.headers)
//        return perform(request: request, completion: completion)
//    }
//}
