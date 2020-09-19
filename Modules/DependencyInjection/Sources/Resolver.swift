import Foundation

public protocol Resolvable {
    func canResolve<T>(dependency: T.Type, named: String) -> Bool
    func resolve<T>(dependency: T.Type, named: String) -> T
}

public enum RetainBehaviour: String, Equatable {
    case singleton
    case none
}

public protocol DependencyContainer {
    func register<T>(_: RetainBehaviour, dependency: T.Type, name: String, implementation: @escaping () -> T)
}

public extension DependencyContainer {
    func register<T>(_ behaviour: RetainBehaviour = .none, dependency: T.Type = T.self, name: String = "Default", implementation: @escaping () -> T) {
        register(behaviour, dependency: dependency, name: name, implementation: implementation)
    }
}

public class Resolver: Resolvable {
    public static let shared = Resolver()

    public static func resolve<T>(dependency: T.Type = T.self, named name: String = "Default") -> T {
        return shared.resolve(dependency: dependency, named: name)
    }

    public var registry: [Resolvable & DependencyContainer] = []

    public init() {}
    
    public func canResolve<T>(dependency: T.Type, named: String) -> Bool {
        for item in registry where item.canResolve(dependency: dependency, named: named) {
            return true
        }
        return false
    }

    public func resolve<T>(dependency: T.Type, named name: String) -> T {
        for item in registry where item.canResolve(dependency: dependency, named: name) {
            return item.resolve(dependency: dependency, named: name)
        }
        fatalError("Cannot find dependency \(dependency)")
    }
}

public protocol Component {
    func registerDependencies(container: DependencyContainer)
}
