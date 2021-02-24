import Foundation

// sourcery: Prism
public enum MoveError: Error, Equatable {
    case houseIsInvalid
    case houseNotAvailable
}
