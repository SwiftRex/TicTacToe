import CombineRex
import Foundation
import SwiftRex

extension EffectMiddleware where InputActionType == GameAction, OutputActionType == BoardAction.Request, StateType == Game?, Dependencies == Void {
    static var gameControllingBoard: EffectMiddleware<GameAction, BoardAction.Request, Void, Void> {
        EffectMiddleware<GameAction, BoardAction.Request, Void, Void>.onAction { action, _, _ in
            switch action {
            case let .turn(.turnAccepted(player, column, row)):
                return .just(.playerMoveAttempt(player: player, column: column, row: row))
            default:
                return .doNothing
            }
        }
    }
}

extension EffectMiddleware where InputActionType == BoardAction.Result, OutputActionType == GameAction, StateType == Game?, Dependencies == Void {
    static var boardResponseToGame: EffectMiddleware<BoardAction.Result, GameAction, Void, Void> {
        EffectMiddleware<BoardAction.Result, GameAction, Void, Void>.onAction { action, _, _ in
            switch action {
            case let .playerMoveAccepted(_, player):
                return .just(.turn(.turnCompleted(player: player)))
            case let .moveError(_, _, _, error):
                return .just(.turn(.moveError(error)))
            }
        }
    }
}
