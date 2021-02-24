import Foundation

// sourcery: Prism
public enum GameState: Equatable {
    case finished(GameResult)
    case empty
    case inGame(turn: Player)
}
