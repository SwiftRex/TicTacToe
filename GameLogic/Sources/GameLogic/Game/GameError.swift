import Foundation

// sourcery: Prism
public enum GameError: Error, Equatable {
    case gameNotStarted
    case wrongPlayer
    case gameOver
    case gameConfigurationIsInvalid
}
