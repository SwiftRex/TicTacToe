// Generated using Sourcery 0.18.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import Foundation
extension BoardAction {
    public var request: Request? {
        get {
            guard case let .request(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .request = self, let newValue = newValue else { return }
            self = .request(newValue)
        }
    }

    public var isRequest: Bool {
        self.request != nil
    }

    public var result: Result? {
        get {
            guard case let .result(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .result = self, let newValue = newValue else { return }
            self = .result(newValue)
        }
    }

    public var isResult: Bool {
        self.result != nil
    }

}
extension GameAction {
    public var start: (length: Int, players: [Player])? {
        get {
            guard case let .start(length, players) = self else { return nil }
            return (length, players)
        }
        set {
            guard case .start = self, let newValue = newValue else { return }
            self = .start(length: newValue.0, players: newValue.1)
        }
    }

    public var isStart: Bool {
        self.start != nil
    }

    public var newGameStarted: Game? {
        get {
            guard case let .newGameStarted(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .newGameStarted = self, let newValue = newValue else { return }
            self = .newGameStarted(newValue)
        }
    }

    public var isNewGameStarted: Bool {
        self.newGameStarted != nil
    }

    public var turn: TurnAction? {
        get {
            guard case let .turn(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .turn = self, let newValue = newValue else { return }
            self = .turn(newValue)
        }
    }

    public var isTurn: Bool {
        self.turn != nil
    }

    public var gameOver: GameResult? {
        get {
            guard case let .gameOver(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .gameOver = self, let newValue = newValue else { return }
            self = .gameOver(newValue)
        }
    }

    public var isGameOver: Bool {
        self.gameOver != nil
    }

    public var gameError: GameError? {
        get {
            guard case let .gameError(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .gameError = self, let newValue = newValue else { return }
            self = .gameError(newValue)
        }
    }

    public var isGameError: Bool {
        self.gameError != nil
    }

    public var board: BoardAction? {
        get {
            guard case let .board(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .board = self, let newValue = newValue else { return }
            self = .board(newValue)
        }
    }

    public var isBoard: Bool {
        self.board != nil
    }

}
extension GameError {
    public var gameNotStarted: Void? {
        get {
            guard case .gameNotStarted = self else { return nil }
            return ()
        }
    }

    public var isGameNotStarted: Bool {
        self.gameNotStarted != nil
    }

    public var wrongPlayer: Void? {
        get {
            guard case .wrongPlayer = self else { return nil }
            return ()
        }
    }

    public var isWrongPlayer: Bool {
        self.wrongPlayer != nil
    }

    public var gameOver: Void? {
        get {
            guard case .gameOver = self else { return nil }
            return ()
        }
    }

    public var isGameOver: Bool {
        self.gameOver != nil
    }

    public var gameConfigurationIsInvalid: Void? {
        get {
            guard case .gameConfigurationIsInvalid = self else { return nil }
            return ()
        }
    }

    public var isGameConfigurationIsInvalid: Bool {
        self.gameConfigurationIsInvalid != nil
    }

}
extension GameResult {
    public var draw: Void? {
        get {
            guard case .draw = self else { return nil }
            return ()
        }
    }

    public var isDraw: Bool {
        self.draw != nil
    }

    public var winner: Player? {
        get {
            guard case let .winner(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .winner = self, let newValue = newValue else { return }
            self = .winner(newValue)
        }
    }

    public var isWinner: Bool {
        self.winner != nil
    }

}
extension GameState {
    public var finished: GameResult? {
        get {
            guard case let .finished(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .finished = self, let newValue = newValue else { return }
            self = .finished(newValue)
        }
    }

    public var isFinished: Bool {
        self.finished != nil
    }

    public var empty: Void? {
        get {
            guard case .empty = self else { return nil }
            return ()
        }
    }

    public var isEmpty: Bool {
        self.empty != nil
    }

    public var inGame: Player? {
        get {
            guard case let .inGame(turn) = self else { return nil }
            return (turn)
        }
        set {
            guard case .inGame = self, let newValue = newValue else { return }
            self = .inGame(turn: newValue)
        }
    }

    public var isInGame: Bool {
        self.inGame != nil
    }

}
extension HouseState {
    public var empty: Void? {
        get {
            guard case .empty = self else { return nil }
            return ()
        }
    }

    public var isEmpty: Bool {
        self.empty != nil
    }

    public var occupied: Player? {
        get {
            guard case let .occupied(associatedValue0) = self else { return nil }
            return (associatedValue0)
        }
        set {
            guard case .occupied = self, let newValue = newValue else { return }
            self = .occupied(newValue)
        }
    }

    public var isOccupied: Bool {
        self.occupied != nil
    }

}
extension MoveError {
    public var houseIsInvalid: Void? {
        get {
            guard case .houseIsInvalid = self else { return nil }
            return ()
        }
    }

    public var isHouseIsInvalid: Bool {
        self.houseIsInvalid != nil
    }

    public var houseNotAvailable: Void? {
        get {
            guard case .houseNotAvailable = self else { return nil }
            return ()
        }
    }

    public var isHouseNotAvailable: Bool {
        self.houseNotAvailable != nil
    }

}
extension PlayerAvatar {
    public var cross: Void? {
        get {
            guard case .cross = self else { return nil }
            return ()
        }
    }

    public var isCross: Bool {
        self.cross != nil
    }

    public var circle: Void? {
        get {
            guard case .circle = self else { return nil }
            return ()
        }
    }

    public var isCircle: Bool {
        self.circle != nil
    }

}
