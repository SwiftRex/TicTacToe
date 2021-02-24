import Foundation

// sourcery: Prism
public enum BoardAction {
    case request(Request)
    case result(Result)
    
    public enum Request {
        case playerMoveAttempt(player: Player, column: Int, row: Int)
    }

    public enum Result {
        case playerMoveAccepted(houseIndex: Int, player: Player)
        case moveError(player: Player, column: Int, row: Int, error: MoveError)
    }
}
