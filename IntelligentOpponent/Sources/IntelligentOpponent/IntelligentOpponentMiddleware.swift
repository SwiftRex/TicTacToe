import Combine
import CombineRex
import Foundation
import GameLogic
import SwiftRex

extension House {
    public var binaryOccupancy: Int {
        switch state {
        case let .occupied(player) where player.isHuman: return 1
        case let .occupied(player) where !player.isHuman: return -1
        default: return 0
        }
    }
}

extension SymmetricalEffectMiddleware where InputActionType == TurnAction, StateType == Game?, Dependencies == ProbabilityCalculator {
    public static var intelligentOpponent: MiddlewareReader<ProbabilityCalculator, SymmetricalEffectMiddleware<TurnAction, Game?, ProbabilityCalculator>> {
        SymmetricalEffectMiddleware.onAction { action, _, getState in
            guard let board = getState()?.board else { return .doNothing }

            switch action {
            case let .playersTurn(player):
                guard !player.isHuman else { return .doNothing }
                return Effect { context -> AnyPublisher<DispatchedAction<TurnAction>, Never> in
                    // Let's simulate all possible moves for this turn. We filter for empty houses and simulate Machine's winning probability for each
                    board
                        .emptyHouses
                        .map { simulatedChosenHouse -> (house: House, winningChance: Double) in
                            // simulatedBoard is a board with binary occupancy (Human: 1, Machine: -1, Empty: 0) but current proposed house already set to -1,
                            // pretending it's occupied by the machine already. ML will calculate how this scenario is good for the Machine.
                            let simulatedBoard = board.houses.map { $0.id == simulatedChosenHouse.id ? -1 : $0.binaryOccupancy }
                            let chance = (try? context.dependencies.calculate(simulatedBoard).get()) ?? -10000
                            return (house: simulatedChosenHouse, winningChance: chance)
                        }
                        .max(by: { $0.winningChance > $1.winningChance }) // Pick the best shot
                        .map { (house, _) in // Map it to the Dispatched Action of TurnAction.turnAttempt
                            Just(DispatchedAction<TurnAction>(.turnAttempt(player: player, column: house.column, row: house.row))).eraseToAnyPublisher()
                        } ?? Empty().eraseToAnyPublisher() // Or if there's no possible move, return an empty publisher
                }
            default:
                return .doNothing
            }
        }
    }
}
