import Foundation

public struct House: Equatable, Identifiable {
    public let id: Int
    public let column: Int
    public let row: Int
    public let state: HouseState
}

extension Collection where Element == House {
    public var allEmpty: Bool {
        allSatisfy { $0.state == .empty }
    }

    public var allOccupied: Bool {
        allSatisfy {
            if case .occupied = $0.state { return true }
            return false
        }
    }

    public var allTheSamePlayer: Player? {
        var potentialWinner: Player? = nil
        for house in self {
            switch house.state {
            case .empty:
                // Any empty house, return immediately, there's no winner
                return nil
            case let .occupied(whoIsThere):
                // It's occupied, but by whom?

                if potentialWinner == nil {
                    // This is the first house we are evaluating,
                    // let's set the potential winner
                    // to the current tenant of this house
                    potentialWinner = whoIsThere
                    continue
                }

                if potentialWinner != whoIsThere {
                    // Previous houses had a different tenant, there's no winner
                    return nil
                }
            }
        }
        
        // All houses have the same player, or there are no houses em this variable is nil anyway
        return potentialWinner
    }
}
