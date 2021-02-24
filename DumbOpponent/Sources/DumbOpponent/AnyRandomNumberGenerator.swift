import Foundation

// TODO: Transform into Writer Monad and stop using reference-type
public class AnyRandomNumberGenerator: RandomNumberGenerator {
    var erasedInstance: RandomNumberGenerator

    public init(_ instance: RandomNumberGenerator) {
        erasedInstance = instance
    }

    public func next() -> UInt64 {
        erasedInstance.next()
    }
}
