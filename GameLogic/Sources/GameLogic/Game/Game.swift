import Foundation

public struct Game: Equatable {
    public var board: Board
    public var gameState: GameState
    public let players: [Player]

    public init?(board: Board, players: [Player]) {
        guard let game = Game(board: board, gameState: .empty, players: players) else { return nil }
        self = game
    }

    init?(board: Board, gameState: GameState, players: [Player]) {
        guard Game.validate(players: players) else { return nil }
        self.board = board
        self.gameState = gameState
        self.players = players
    }

    public func next(after currentPlayer: Player) -> Player? {
        guard let indexCurrent = players.firstIndex(of: currentPlayer) else { return nil }
        let nextIndex = players.index(after: indexCurrent)
        if nextIndex == players.endIndex {
            // When last player had its turn, goes back to the first
            return players.first
        } else {
            // Otherwise, go to the next in the list
            return players[nextIndex]
        }
    }

    private static func validate(players: [Player]) -> Bool {
        players.count > 1 && // Can't play alone
            Set(players.map(\.avatar.rawValue)).count == players.count // Can't use same avatar for different players
    }
}
