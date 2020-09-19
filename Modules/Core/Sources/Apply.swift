import Foundation

public protocol Apply {}

public extension Apply where Self: Any {
    func apply(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}
