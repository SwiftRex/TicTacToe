@testable import GameLogic
import XCTest

class BoardTests: XCTestCase {
    func testEmptyBoardMinusOne() {
        let board = Board(length: -1)
        XCTAssertNil(board)
    }

    func testEmptyBoard0x0() {
        let board = Board(length: 0)
        XCTAssertNil(board)
    }

    func testEmptyBoard1x1Description() {
        let board = Board(length: 1)
        XCTAssertEqual(
            """
            -----
            |   |
            -----
            """,
            board?.description
        )
    }

    func testEmptyBoard2x2Description() {
        let board = Board(length: 2)
        XCTAssertEqual(
            """
            ---------
            |   |   |
            ---------
            |   |   |
            ---------
            """,
            board?.description
        )
    }

    func testEmptyBoard3x3Description() {
        let board = Board(length: 3)
        XCTAssertEqual(
            """
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            """,
            board?.description
        )
    }

    func testEmptyBoard1x1Rows() {
        let board = Board(length: 1)
        XCTAssertEqual(board?.rows.count, 1)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty)
            ],
            board?.rows[0]
        )
    }

    func testEmptyBoard2x2Rows() {
        let board = Board(length: 2)
        XCTAssertEqual(board?.rows.count, 2)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty),
                House(column: 1, row: 0, state: .empty)
            ],
            board?.rows[0]
        )

        XCTAssertEqual(
            [
                House(column: 0, row: 1, state: .empty),
                House(column: 1, row: 1, state: .empty)
            ],
            board?.rows[1]
        )
    }

    func testEmptyBoard3x3Rows() {
        let board = Board(length: 3)
        XCTAssertEqual(board?.rows.count, 3)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty),
                House(column: 1, row: 0, state: .empty),
                House(column: 2, row: 0, state: .empty)
            ],
            board?.rows[0]
        )

        XCTAssertEqual(
            [
                House(column: 0, row: 1, state: .empty),
                House(column: 1, row: 1, state: .empty),
                House(column: 2, row: 1, state: .empty)
            ],
            board?.rows[1]
        )

        XCTAssertEqual(
            [
                House(column: 0, row: 2, state: .empty),
                House(column: 1, row: 2, state: .empty),
                House(column: 2, row: 2, state: .empty)
            ],
            board?.rows[2]
        )
    }

    func testEmptyBoard1x1Columns() {
        let board = Board(length: 1)
        XCTAssertEqual(board?.columns.count, 1)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty)
            ],
            board?.columns[0]
        )
    }

    func testEmptyBoard2x2Columns() {
        let board = Board(length: 2)
        XCTAssertEqual(board?.columns.count, 2)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty),
                House(column: 0, row: 1, state: .empty)
            ],
            board?.columns[0]
        )

        XCTAssertEqual(
            [
                House(column: 1, row: 0, state: .empty),
                House(column: 1, row: 1, state: .empty)
            ],
            board?.columns[1]
        )
    }

    func testEmptyBoard3x3Columns() {
        let board = Board(length: 3)
        XCTAssertEqual(board?.columns.count, 3)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty),
                House(column: 0, row: 1, state: .empty),
                House(column: 0, row: 2, state: .empty)
            ],
            board?.columns[0]
        )

        XCTAssertEqual(
            [
                House(column: 1, row: 0, state: .empty),
                House(column: 1, row: 1, state: .empty),
                House(column: 1, row: 2, state: .empty)
            ],
            board?.columns[1]
        )

        XCTAssertEqual(
            [
                House(column: 2, row: 0, state: .empty),
                House(column: 2, row: 1, state: .empty),
                House(column: 2, row: 2, state: .empty)
            ],
            board?.columns[2]
        )
    }

    func testEmptyBoard1x1Diagonals() {
        let board = Board(length: 1)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty)
            ],
            board?.diagonals.topLeftToBottomRight
        )

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty)
            ],
            board?.diagonals.topRightToBottomLeft
        )
    }

    func testEmptyBoard2x2Diagonals() {
        let board = Board(length: 2)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty),
                House(column: 1, row: 1, state: .empty)
            ],
            board?.diagonals.topLeftToBottomRight
        )

        XCTAssertEqual(
            [
                House(column: 1, row: 0, state: .empty),
                House(column: 0, row: 1, state: .empty)
            ],
            board?.diagonals.topRightToBottomLeft
        )
    }

    func testEmptyBoard3x3Diagonals() {
        let board = Board(length: 3)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty),
                House(column: 1, row: 1, state: .empty),
                House(column: 2, row: 2, state: .empty)
            ],
            board?.diagonals.topLeftToBottomRight
        )

        XCTAssertEqual(
            [
                House(column: 2, row: 0, state: .empty),
                House(column: 1, row: 1, state: .empty),
                House(column: 0, row: 2, state: .empty)
            ],
            board?.diagonals.topRightToBottomLeft
        )
    }

    func testEmptyBoard4x4Diagonals() {
        let board = Board(length: 4)

        XCTAssertEqual(
            [
                House(column: 0, row: 0, state: .empty),
                House(column: 1, row: 1, state: .empty),
                House(column: 2, row: 2, state: .empty),
                House(column: 3, row: 3, state: .empty)
            ],
            board?.diagonals.topLeftToBottomRight
        )

        XCTAssertEqual(
            [
                House(column: 3, row: 0, state: .empty),
                House(column: 2, row: 1, state: .empty),
                House(column: 1, row: 2, state: .empty),
                House(column: 0, row: 3, state: .empty)
            ],
            board?.diagonals.topRightToBottomLeft
        )
    }

    func testHappyPathMoves() throws {
        var board = Board(length: 3)
        
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 1, row: 0, state: .empty), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .empty), House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .circle, column: 1, row: 0).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .empty), House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            |   | o |   |
            -------------
            |   |   |   |
            -------------
            |   |   |   |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .cross, column: 0, row: 2).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            |   | o |   |
            -------------
            |   |   |   |
            -------------
            | x |   |   |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .circle, column: 1, row: 1).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .occupied(.circle)), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            |   | o |   |
            -------------
            |   | o |   |
            -------------
            | x |   |   |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .cross, column: 1, row: 2).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .occupied(.circle)), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .occupied(.cross)), House(column: 2, row: 2, state: .empty)
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            |   | o |   |
            -------------
            |   | o |   |
            -------------
            | x | x |   |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .circle, column: 2, row: 2).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .occupied(.circle)), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .occupied(.cross)), House(column: 2, row: 2, state: .occupied(.circle))
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            |   | o |   |
            -------------
            |   | o |   |
            -------------
            | x | x | o |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .cross, column: 0, row: 0).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .occupied(.cross)), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .occupied(.circle)), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .occupied(.cross)), House(column: 2, row: 2, state: .occupied(.circle))
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            | x | o |   |
            -------------
            |   | o |   |
            -------------
            | x | x | o |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .circle, column: 0, row: 1).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .occupied(.cross)), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .occupied(.circle)), House(column: 1, row: 1, state: .occupied(.circle)), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .occupied(.cross)), House(column: 2, row: 2, state: .occupied(.circle))
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            | x | o |   |
            -------------
            | o | o |   |
            -------------
            | x | x | o |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .cross, column: 2, row: 1).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .occupied(.cross)), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .occupied(.circle)), House(column: 1, row: 1, state: .occupied(.circle)), House(column: 2, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .occupied(.cross)), House(column: 2, row: 2, state: .occupied(.circle))
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            | x | o |   |
            -------------
            | o | o | x |
            -------------
            | x | x | o |
            -------------
            """,
            board?.description
        )

        board = try board?.includingMove(player: .circle, column: 2, row: 0).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .occupied(.cross)), House(column: 1, row: 0, state: .occupied(.circle)), House(column: 2, row: 0, state: .occupied(.circle)),
            House(column: 0, row: 1, state: .occupied(.circle)), House(column: 1, row: 1, state: .occupied(.circle)), House(column: 2, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .occupied(.cross)), House(column: 1, row: 2, state: .occupied(.cross)), House(column: 2, row: 2, state: .occupied(.circle))
        ], board?.houses)
        XCTAssertEqual(
            """
            -------------
            | x | o | o |
            -------------
            | o | o | x |
            -------------
            | x | x | o |
            -------------
            """,
            board?.description
        )
    }

    func testHappyPathEmptyHouses() throws {
        var board = Board(length: 3)

        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 1, row: 0, state: .empty), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .empty), House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .circle, column: 1, row: 0).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 0, row: 2, state: .empty), House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .cross, column: 0, row: 2).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 1, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .circle, column: 1, row: 1).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 1, row: 2, state: .empty), House(column: 2, row: 2, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .cross, column: 1, row: 2).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 2, row: 1, state: .empty),
            House(column: 2, row: 2, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .circle, column: 2, row: 2).get()
        XCTAssertEqual([
            House(column: 0, row: 0, state: .empty), House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 2, row: 1, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .cross, column: 0, row: 0).get()
        XCTAssertEqual([
            House(column: 2, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty), House(column: 2, row: 1, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .circle, column: 0, row: 1).get()
        XCTAssertEqual([
            House(column: 2, row: 0, state: .empty),
            House(column: 2, row: 1, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .cross, column: 2, row: 1).get()
        XCTAssertEqual([
            House(column: 2, row: 0, state: .empty)
        ], board?.emptyHouses)

        board = try board?.includingMove(player: .circle, column: 2, row: 0).get()
        XCTAssertEqual([], board?.emptyHouses)
    }

    func testTryingToMoveToOccupiedHouse() throws {
        var board = Board(length: 3)

        board = try board?.includingMove(player: .circle, column: 1, row: 0).get()
        let result = board?.includingMove(player: .circle, column: 1, row: 0)
        XCTAssertEqual(result, .failure(.houseNotAvailable))
    }

    func testTryingToMoveToInvalidColumn() throws {
        var board = Board(length: 3)

        board = try board?.includingMove(player: .circle, column: 1, row: 0).get()
        let result = board?.includingMove(player: .circle, column: 3, row: 0)
        XCTAssertEqual(result, .failure(.houseIsInvalid))
    }

    func testTryingToMoveToInvalidRow() throws {
        var board = Board(length: 3)

        board = try board?.includingMove(player: .circle, column: 1, row: 0).get()
        let result = board?.includingMove(player: .circle, column: 0, row: 3)
        XCTAssertEqual(result, .failure(.houseIsInvalid))
    }
}
