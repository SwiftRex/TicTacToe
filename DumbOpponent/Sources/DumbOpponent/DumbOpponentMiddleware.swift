import Combine
import CombineRex
import Foundation
import GameLogic
import SwiftRex

extension SymmetricalEffectMiddleware where InputActionType == TurnAction, StateType == Game?, Dependencies == AnyRandomNumberGenerator {
    public static var dumbOpponent: MiddlewareReader<AnyRandomNumberGenerator, SymmetricalEffectMiddleware<TurnAction, Game?, AnyRandomNumberGenerator>> {
        SymmetricalEffectMiddleware.onAction { action, _, getState in
            switch action {    
            case let .playersTurn(player):
                guard !player.isHuman else { return .doNothing }
                return Effect
                    .randomElement(from: getState()?.board.emptyHouses ?? [])
                    .map { house in
                        .turnAttempt(player: player, column: house.column, row: house.row)
                    }
            default:
                return .doNothing
            }
        }
    }
}

/// A very generic effect that picks one element from a collection, using an injected RandomNumberGenerator
extension Effect where Dependencies == AnyRandomNumberGenerator {
    public static func randomElement<C: Collection>(from collection: C) -> Effect<Dependencies, C.Element> where C.Element == OutputAction {
        Effect { context -> AnyPublisher<DispatchedAction<OutputAction>, Never> in
            var randomiser = context.dependencies
            return collection.randomElement(using: &randomiser)
                    .map { DispatchedAction($0) }
                    .map(Just.init).map { $0.eraseToAnyPublisher() }
                ?? Empty().eraseToAnyPublisher()
        }
    }
}
