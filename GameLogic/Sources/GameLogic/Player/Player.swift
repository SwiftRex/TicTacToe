import Foundation

public struct Player: Equatable, CustomStringConvertible {
    public init(avatar: PlayerAvatar, isHuman: Bool) {
        self.avatar = avatar
        self.isHuman = isHuman
    }

    public let avatar: PlayerAvatar
    public let isHuman: Bool

    public var description: String {
        "\(avatar) (\(isHuman ? "Human" : "CPU"))"
    }
}

// sourcery: Prism
public enum PlayerAvatar: String, Equatable, CustomStringConvertible {
    case cross = "x"
    case circle = "o"

    public var description: String {
        rawValue
    }

    public var other: PlayerAvatar {
        switch self {
        case .circle: return .cross
        case .cross: return .circle
        }
    }
}
