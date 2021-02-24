import Foundation

// sourcery: Prism
public enum HouseState: Equatable, CustomStringConvertible {
    case empty
    case occupied(Player)

    public var description: String {
        switch self {
        case .empty: return "   "
        case let .occupied(player): return " \(player.description) "
        }
    }
}
