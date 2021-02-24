import Foundation

// sourcery: Prism
public enum GameResult: Equatable {
    case draw
    case winner(Player)
}
