import CombineRex
import Foundation
import SwiftRex

extension SymmetricalEffectMiddleware where InputActionType == GameAction, StateType == Game?, Dependencies == Void {
    static var game: SymmetricalEffectMiddleware<GameAction, Game?, Void> {
        SymmetricalEffectMiddleware.onAction { action, _, getState in
            switch action {
            case let .start(length, players):
                return Effect.startGame(length: length, players: players)
            case let .turn(.turnAttempt(player, column, row)):
                return Effect.evaluateTurn(player: player, column: column, row: row, game: getState())
            case .turn(.turnCompleted):
                switch getState()?.gameState {
                case let .inGame(turn):
                    return .just(.turn(.playersTurn(turn)))
                case let .finished(result):
                    return .just(.gameOver(result))
                default:
                    return .doNothing
                }
            case .turn, .gameError, .newGameStarted, .gameOver, .board:
                return .doNothing
            }
        }
    }
}

extension Effect where Dependencies == Void, OutputAction == GameAction {
    fileprivate static func startGame(length: Int, players: [Player]) -> Effect {
        Board(length: length)
            .map { (board: $0, players: players) }
            .flatMap(Game.init)
            .map(GameAction.newGameStarted)
            .map { Effect.just($0) }
        ?? .just(.gameError(.gameConfigurationIsInvalid))
    }

    fileprivate static func evaluateTurn(player: Player, column: Int, row: Int, game: Game?) -> Effect {
        switch game?.gameState {
        case .finished:
            return .just(.gameError(.gameOver))
        case let .inGame(whoShouldPlay) where whoShouldPlay != player:
            return .just(.gameError(.wrongPlayer))
        case .inGame, .empty:
            return .just(.turn(.turnAccepted(player: player, column: column, row: row)))
        case .none:
            return .just(.gameError(.gameNotStarted))
        }

    }
}
