import CombineRex
import Foundation
import SwiftRex

extension EffectMiddleware where InputActionType == BoardAction.Request, OutputActionType == BoardAction.Result, StateType == Board?, Dependencies == Void {
    static var board: EffectMiddleware<BoardAction.Request, BoardAction.Result, Board?, Void> {
        EffectMiddleware.onAction { action, _, getState in
            switch action {
            case let .playerMoveAttempt(player, column, row):
                guard let board = getState() else { return .doNothing }
                return Effect.playerMoveAttempt(player: player, column: column, row: row, board: board)
            }
        }
    }
}

extension Effect where Dependencies == Void, OutputAction == BoardAction.Result {
    fileprivate static func playerMoveAttempt(player: Player, column: Int, row: Int, board: Board) -> Effect {
        guard let houseIndex = board.houses.firstIndex(where: { $0.column == column && $0.row == row }),
              let house = board.houses[safe: houseIndex]
        else { return .just(.moveError(player: player, column: column, row: row, error: .houseIsInvalid)) }

        guard house.state == .empty
        else { return .just(.moveError(player: player, column: column, row: row, error: .houseNotAvailable)) }

        return .just(.playerMoveAccepted(houseIndex: houseIndex, player: player))
    }
}
