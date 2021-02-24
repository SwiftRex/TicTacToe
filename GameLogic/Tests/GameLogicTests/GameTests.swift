@testable import GameLogic
import XCTest

class GameTests: XCTestCase {
    func testInitialState() throws {
        let game = Game(board: try XCTUnwrap(Board(length: 3)))
        XCTAssertEqual(game.gameState, .empty)
    }

    func testStartWithCircleTurnIsCross() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        XCTAssertEqual(game.gameState, .inGame(turn: .cross))
    }

    func testStartWithCrossTurnIsCircle() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .cross, column: 0, row: 0).get()
        XCTAssertEqual(game.gameState, .inGame(turn: .circle))
    }

    func testCircleCrossTurnIsCircleAgain() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        game = try game.turn(player: .cross, column: 1, row: 1).get()
        XCTAssertEqual(game.gameState, .inGame(turn: .circle))
    }

    func testCrossCircleTurnIsCrossAgain() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .cross, column: 1, row: 1).get()
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        XCTAssertEqual(game.gameState, .inGame(turn: .cross))
    }

    func testCircleCircleGivesAnError() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        let result = game.turn(player: .circle, column: 1, row: 1)
        XCTAssertEqual(result, .failure(.wrongPlayer))
    }

    func testCrossCrossGivesAnError() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .cross, column: 0, row: 0).get()
        let result = game.turn(player: .cross, column: 1, row: 1)
        XCTAssertEqual(result, .failure(.wrongPlayer))
    }

    func testCircleWins() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        game = try game.turn(player: .cross, column: 1, row: 1).get()
        game = try game.turn(player: .circle, column: 2, row: 2).get()
        game = try game.turn(player: .cross, column: 2, row: 0).get()
        game = try game.turn(player: .circle, column: 0, row: 2).get()
        game = try game.turn(player: .cross, column: 0, row: 1).get()
        game = try game.turn(player: .circle, column: 1, row: 2).get()
        XCTAssertEqual(game.gameState, .finished(.winner(.circle)))

        let result = game.turn(player: .circle, column: 0, row: 0)
        XCTAssertEqual(result, .failure(.gameOver))
    }

    func testCrossWins() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        game = try game.turn(player: .cross, column: 1, row: 1).get()
        game = try game.turn(player: .circle, column: 2, row: 2).get()
        game = try game.turn(player: .cross, column: 2, row: 1).get()
        game = try game.turn(player: .circle, column: 0, row: 2).get()
        game = try game.turn(player: .cross, column: 0, row: 1).get()
        XCTAssertEqual(game.gameState, .finished(.winner(.cross)))

        let result = game.turn(player: .circle, column: 1, row: 2)
        XCTAssertEqual(result, .failure(.gameOver))
    }

    func testDraw() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        game = try game.turn(player: .cross, column: 2, row: 2).get()
        game = try game.turn(player: .circle, column: 2, row: 0).get()
        game = try game.turn(player: .cross, column: 1, row: 0).get()
        game = try game.turn(player: .circle, column: 1, row: 1).get()
        game = try game.turn(player: .cross, column: 0, row: 2).get()
        game = try game.turn(player: .circle, column: 2, row: 1).get()
        game = try game.turn(player: .cross, column: 0, row: 1).get()
        game = try game.turn(player: .circle, column: 1, row: 2).get()
        XCTAssertEqual(game.gameState, .finished(.draw))

        let result = game.turn(player: .cross, column: 1, row: 2)
        XCTAssertEqual(result, .failure(.gameOver))
    }

    func testWinOnTheLastMove() throws {
        var game = Game(board: try XCTUnwrap(Board(length: 3)))
        game = try game.turn(player: .circle, column: 0, row: 0).get()
        game = try game.turn(player: .cross, column: 1, row: 0).get()
        game = try game.turn(player: .circle, column: 2, row: 0).get()
        game = try game.turn(player: .cross, column: 1, row: 1).get()
        game = try game.turn(player: .circle, column: 1, row: 2).get()
        game = try game.turn(player: .cross, column: 2, row: 2).get()
        game = try game.turn(player: .circle, column: 0, row: 1).get()
        game = try game.turn(player: .cross, column: 2, row: 1).get()
        game = try game.turn(player: .circle, column: 0, row: 2).get()
        XCTAssertEqual(game.gameState, .finished(.winner(.circle)))

        let result = game.turn(player: .cross, column: 1, row: 2)
        XCTAssertEqual(result, .failure(.gameOver))
    }
}
