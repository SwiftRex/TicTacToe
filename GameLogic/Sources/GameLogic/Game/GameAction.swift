import Foundation

// sourcery: Prism
public enum GameAction {
    case start(length: Int, players: [Player])
    case newGameStarted(Game)
    case turn(TurnAction)
    case gameOver(GameResult)
    case gameError(GameError)
    case board(BoardAction)
}

public enum TurnAction {
    case turnAttempt(player: Player, column: Int, row: Int)
    case turnAccepted(player: Player, column: Int, row: Int)
    case turnCompleted(player: Player)
    case playersTurn(Player)
    case moveError(MoveError)
}
