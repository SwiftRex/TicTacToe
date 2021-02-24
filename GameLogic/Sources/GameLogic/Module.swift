import CombineRex
import Foundation
import SwiftRex

public enum Module {
    public static var reducer: Reducer<GameAction, Game?> {
        [
            Reducer.game,
            Reducer.board
                .lift(action: \.board?.result, state: \.board)
                .liftToOptionalState()
        ].reduce(.identity, <>)
    }

    public static var middleware: EffectMiddleware<GameAction, GameAction, Game?, Void> {
        SymmetricalEffectMiddleware.game

        <> EffectMiddleware.gameControllingBoard.lift(
            outputAction: { GameAction.board(.request($0)) },
            state: { _ in }
        )

        <> EffectMiddleware.boardResponseToGame.lift(
            inputAction: \.board?.result,
            state: { _ in }
        )

        <> EffectMiddleware.board.lift(
            inputAction: \.board?.request,
            outputAction: { GameAction.board(.result($0)) },
            state: { $0?.board }
        )
    }
}

extension Reducer {
    func liftToOptionalState() -> Reducer<ActionType, StateType?> {
        .reduce { action, state in
            guard var unwrappedState = state else { return }
            self.reduce(action, &unwrappedState)
            state = unwrappedState
        }
    }
}
