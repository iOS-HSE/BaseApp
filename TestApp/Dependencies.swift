////
////  Dependencies.swift
////  TestApp
////
////  Created by Сергей Мирошниченко on 18.09.2020.
////  Copyright © 2020 7rlines. All rights reserved.
////
//
//import Foundation
//import DependencyInjection
//import SDK
//import Swinject
//import Persistency
//import Logging
//
//class Dependencies: Resolvable, DependencyContainer {
//    
//    private let container = Container()
//    
//    typealias Resolver = DependencyInjection.Resolver
//    
//    func registerDependencies(container: DependencyContainer) {
//        
//        register { URLSession.shared as HTTPLibrary }
//        
//        register { Networking(httpLibrary: Resolver.resolve()) as NetworkingProtocol }
//        
//        register { SDK(networking: Resolver.resolve(), scheduler: MainThreadScheduler()) }
//        
//        register { InMemoryCache() }
//        
//        register { PersistentCache() }
//        
//        register { ConsoleLogger() as AnalyticsLoggerProtocol }
//        
//        register { ErrorLogger() as ErrorLoggerProtocol }
//        
//        register { Resolver.resolve() as SDK as CategoriesRequestable }
//        
//        register { FetchCategoriesUseCase(fetcher: Resolver.resolve(),
//                                          cache: Resolver.resolve() as PersistentCache,
//                                          analyticsLogger: Resolver.resolve(),
//                                          errorLogger: Resolver.resolve()) as FetchCategoriesUseCaseProtocol }
//        
//        register { CategoriesVC(fetcher: Resolver.resolve()) }
//        
//    }
//    
//    // Implementation details to integrate Swinject with Resolvable
//    
//    init() {
//        Resolver.shared.registry.append(self)
//    }
//
//    func registerDependencies() {
//        registerDependencies(container: self)
//    }
//    
//    public func register<T>(_ behaviour: RetainBehaviour, dependency: T.Type, name: String, implementation: @escaping () -> T) {
//        container.register(dependency, name: name) { _ in
//            implementation()
//        }.inObjectScope(behaviour == .singleton ? .container : .transient)
//    }
//    
//    public func canResolve<T>(dependency: T.Type, named: String) -> Bool {
//        return true
//    }
//
//    public func resolve<T>(dependency: T.Type, named name: String) -> T {
//        return container.synchronize().resolve(dependency, name: name)!
//    }
//}
