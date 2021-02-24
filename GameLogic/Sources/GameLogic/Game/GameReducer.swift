import Foundation
import SwiftRex

extension Reducer where ActionType == GameAction, StateType == Game? {
    static let game = Reducer.reduce { action, state in
        switch action {
        case let .newGameStarted(game):
            state = game
        case let .turn(.turnCompleted(player)):
            guard var game = state else { return }
            game.gameState = hasFinished(board: game.board).map(GameState.finished)
                ?? game.next(after: player).map(GameState.inGame(turn:))
                ?? .empty
            state = game
        case .start, .turn, .gameError, .gameOver, .board:
            break
        }
    }
}

private func hasFinished(board: Board) -> GameResult? {
    let rows: [[House]] = board.rows.values.map { $0 }
    let columns: [[House]] = board.columns.values.map { $0 }
    let diagonals = board.diagonals

    if let winner = (rows + columns + [diagonals.topLeftToBottomRight, diagonals.topRightToBottomLeft])
        .compactMap({ alignedHouses in
            alignedHouses.allTheSamePlayer
        })
        .first {
        return .winner(winner)
    }

    if board.houses.allSatisfy({ $0.state.isOccupied }) {
        return .draw
    }

    return nil
}
