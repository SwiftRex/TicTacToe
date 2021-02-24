import Foundation
import SwiftRex

extension Reducer where ActionType == BoardAction.Result, StateType == Board {
    static let board = Reducer.reduce { action, state in
        switch action {
        case let .playerMoveAccepted(houseIndex, player):
            guard let oldHouse = state.houses[safe: houseIndex] else { return }
            state.houses[safe: houseIndex] = House(id: oldHouse.id, column: oldHouse.column, row: oldHouse.row, state: .occupied(player))
        case .moveError:
            break
        }
    }
}
