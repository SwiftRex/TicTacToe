import Foundation

extension Result where Failure: Equatable {
    func `is`(error: Failure) -> Bool {
        switch self {
        case .success: return false
        case let .failure(innerError): return innerError == error
        }
    }
}
