////
////  FeedUseCase.swift
////  TestApp
////
////  Created by Сергей Мирошниченко on 19.09.2020.
////  Copyright © 2020 7rlines. All rights reserved.
////
//
//import Foundation
//import SDK
//import Persistency
//import Logging
//
//typealias CategoriesCompletion = Completion<Categories>
//
//protocol FetchCategoriesUseCaseProtocol {
//    @discardableResult
//    func fetchCategories(loader: Loader, completion: @escaping CategoriesCompletion) -> Cancellable?
//}
//
//class FetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {
//    
//    let fetcher: CategoriesRequestable
//    let cache: GenericCache
//    let analyticsLogger: AnalyticsLoggerProtocol
//    let errorLogger: ErrorLoggerProtocol
//    
//    init(fetcher: CategoriesRequestable,
//         cache: GenericCache,
//         analyticsLogger: AnalyticsLoggerProtocol,
//         errorLogger: ErrorLoggerProtocol) {
//        self.fetcher = fetcher
//        self.cache = cache
//        self.analyticsLogger = analyticsLogger
//        self.errorLogger = errorLogger
//    }
//    
//    enum CacheKeys: String {
//        case categories
//    }
//    
//    @discardableResult
//    func fetchCategories(loader: Loader, completion: @escaping CategoriesCompletion) -> Cancellable? {
//        let behaviours: [CategoriesEventListener] = [
//            ErrorLoggingBehaviour(logger: self.errorLogger),
//            AnalyticsLoggingBehaviour(logger: self.analyticsLogger),
//            LoadingBehaviour(loader: loader)
//        ]
//        return fetchCategories(behaviours: behaviours, completion: completion)
//    }
//    
//    private func fetchCategories(behaviours: [CategoriesEventListener], completion: @escaping CategoriesCompletion) -> Cancellable? {
//        behaviours.notify(.willBeginLoading)
//
//        var didUseCache = false
//        if let cachedValue = cache[CacheKeys.categories.rawValue] as Categories? {
//            didUseCache = true
//            completion(cachedValue)
//            behaviours.notify(.didUpdateData(source: .cache))
//        }
//        behaviours.notify(.willBeginNetworkOperation(hasCachedData: didUseCache))
//        return fetcher.fetchCategories(from: .categories) { result in
//            behaviours.notify(.didFinishNetworkOperation)
//            switch result {
//            case let .failure(error):
//                behaviours.notify(.didFail(error: error))
//            case let .success(categories):
//                self.cache[CacheKeys.categories.rawValue] = categories
//                completion(categories)
//                behaviours.notify(.didUpdateData(source: .latest))
//            }
//        }
//    }
//    
//    private class ErrorLoggingBehaviour: CategoriesEventListener {
//        let logger: ErrorLoggerProtocol
//        init(logger: ErrorLoggerProtocol) {
//            self.logger = logger
//        }
//        func handle(event: CategoriesEvent) {
//            switch event {
//            case let .didFail(error):
//                logger.logError(error: error, info: "Fetching card list")
//            default:
//                break
//            }
//        }
//    }
//    
//    private class AnalyticsLoggingBehaviour: CategoriesEventListener {
//        let logger: AnalyticsLoggerProtocol
//        init(logger: AnalyticsLoggerProtocol) {
//            self.logger = logger
//        }
//        func handle(event: CategoriesEvent) {
//            switch event {
//                case let .didFail(error):
//                    logger.logEvent(name: "Card list fetch failed", parameters: ["message": error.alertMessage])
//                case .didUpdateData(.latest):
//                    logger.logEvent(name: "Card list loaded", parameters: [:])
//                default:
//                    break
//            }
//        }
//    }
//    
//    private class LoadingBehaviour: CategoriesEventListener {
//        let loader: Loader
//        init(loader: Loader) {
//            self.loader = loader
//        }
//        func handle(event: CategoriesEvent) {
//            switch event {
//                case let .willBeginNetworkOperation(hasCachedData):
//                    if !hasCachedData {
//                        loader.showIndicator()
//                    }
//                case .didFinishNetworkOperation:
//                    loader.hideIndicator()
//                case let .didFail(error):
//                    loader.createAlert(message: error.alertMessage)
//                default:
//                    break
//            }
//        }
//    }
//}
//
//enum Source {
//    case cache
//    case latest
//}
//
//enum CategoriesEvent {
//    case willBeginLoading
//    case willBeginNetworkOperation(hasCachedData: Bool)
//    case didFinishNetworkOperation
//    case didUpdateData(source: Source)
//    case didFail(error: APIError)
//}
//
//protocol CategoriesEventListener {
//    func handle(event: CategoriesEvent)
//}
//
//extension Array where Element == CategoriesEventListener {
//    func notify(_ event: CategoriesEvent) {
//        forEach {
//            $0.handle(event: event)
//        }
//    }
//}
