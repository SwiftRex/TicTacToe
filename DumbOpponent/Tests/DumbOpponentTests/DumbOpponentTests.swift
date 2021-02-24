@testable import GameLogic
import XCTest
@testable import DumbOpponent

final class DumbOpponentTests: XCTestCase {
    func testPlayStartingWithCircleHuman() throws {
        let randomizer = Xoshiro(seed: 0)
        let human = Player.circle

        var partial = try Game.playAgainstDumbOpponent(human: human, whoStarts: human, random: randomizer).get()
        XCTAssertEqual(partial.game.gameState, .empty)
        XCTAssertEqual(
            partial.game.board.description,
            """
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            """
        )

        partial = try partial.humanMove(column: 0, row: 0).get()
        XCTAssertEqual(partial.game.gameState, .inGame(turn: human))
        XCTAssertEqual(
            partial.game.board.description,
            """
            -------------
            | o |   | x |
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            """
        )

        var wrongMove = partial.humanMove(column: 2, row: 0)
        XCTAssertTrue(wrongMove.is(error: .houseNotAvailable))
        wrongMove = partial.humanMove(column: 0, row: 0)
        XCTAssertTrue(wrongMove.is(error: .houseNotAvailable))

        partial = try partial.humanMove(column: 1, row: 1).get()
        XCTAssertEqual(partial.game.gameState, .inGame(turn: human))
        XCTAssertEqual(
            partial.game.board.description,
            """
            -------------
            | o | x | x |
            -------------
            |   | o |   |
            -------------
            |   |   |   |
            -------------
            """
        )

        wrongMove = partial.humanMove(column: 2, row: 0)
        XCTAssertTrue(wrongMove.is(error: .houseNotAvailable))
        wrongMove = partial.humanMove(column: 0, row: 0)
        XCTAssertTrue(wrongMove.is(error: .houseNotAvailable))
        wrongMove = partial.humanMove(column: 1, row: 0)
        XCTAssertTrue(wrongMove.is(error: .houseNotAvailable))
        wrongMove = partial.humanMove(column: 1, row: 1)
        XCTAssertTrue(wrongMove.is(error: .houseNotAvailable))
    }
}
