@testable import GameLogic
import XCTest

class HouseStateTests: XCTestCase {
    func testHouseDescriptions() {
        XCTAssertEqual(HouseState.empty.description, "   ")
        XCTAssertEqual(HouseState.occupied(.circle).description, " o ")
        XCTAssertEqual(HouseState.occupied(.cross).description, " x ")
    }

    func testHousesAllEmptyTrue() {
        XCTAssertTrue([
            House(column: 0, row: 0, state: .empty),
            House(column: 0, row: 1, state: .empty),
            House(column: 0, row: 2, state: .empty)
        ].allEmpty)
    }

    func testHousesAllEmptyFalse() {
        XCTAssertFalse([
            House(column: 0, row: 0, state: .empty),
            House(column: 0, row: 1, state: .occupied(.circle)),
            House(column: 0, row: 2, state: .empty)
        ].allEmpty)
    }

    func testHousesAllOccupiedTrue() {
        XCTAssertTrue([
            House(column: 0, row: 0, state: .occupied(.circle)),
            House(column: 0, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .occupied(.circle))
        ].allOccupied)
    }

    func testHousesAllOccupiedFalse() {
        XCTAssertFalse([
            House(column: 0, row: 0, state: .occupied(.circle)),
            House(column: 0, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.circle))
        ].allOccupied)
    }

    func testHousesAllCrossTrue() {
        XCTAssertTrue([
            House(column: 0, row: 0, state: .occupied(.cross)),
            House(column: 0, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .occupied(.cross))
        ].allCross)
    }

    func testHousesAllCrossFalseBecauseCircle() {
        XCTAssertFalse([
            House(column: 0, row: 0, state: .occupied(.cross)),
            House(column: 0, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .occupied(.circle))
        ].allCross)
    }

    func testHousesAllCrossFalseBecauseEmpty() {
        XCTAssertFalse([
            House(column: 0, row: 0, state: .occupied(.cross)),
            House(column: 0, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .empty)
        ].allCross)
    }

    func testHousesAllCircleTrue() {
        XCTAssertTrue([
            House(column: 0, row: 0, state: .occupied(.circle)),
            House(column: 0, row: 1, state: .occupied(.circle)),
            House(column: 0, row: 2, state: .occupied(.circle))
        ].allCircle)
    }

    func testHousesAllCircleFalseBecauseCross() {
        XCTAssertFalse([
            House(column: 0, row: 0, state: .occupied(.circle)),
            House(column: 0, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .occupied(.circle))
        ].allCircle)
    }

    func testHousesAllCircleFalseBecauseEmpty() {
        XCTAssertFalse([
            House(column: 0, row: 0, state: .occupied(.circle)),
            House(column: 0, row: 1, state: .occupied(.circle)),
            House(column: 0, row: 2, state: .empty)
        ].allCircle)
    }

    func testHousesAllSamePlayerCircleTrue() {
        XCTAssertEqual([
            House(column: 0, row: 0, state: .occupied(.circle)),
            House(column: 0, row: 1, state: .occupied(.circle)),
            House(column: 0, row: 2, state: .occupied(.circle))
        ].allTheSamePlayer, .circle)
    }

    func testHousesAllSamePlayerCrossTrue() {
        XCTAssertEqual([
            House(column: 0, row: 0, state: .occupied(.cross)),
            House(column: 0, row: 1, state: .occupied(.cross)),
            House(column: 0, row: 2, state: .occupied(.cross))
        ].allTheSamePlayer, .cross)
    }

    func testHousesAllSamePlayerFalseBecauseDifferent() {
        XCTAssertNil([
            House(column: 0, row: 0, state: .occupied(.cross)),
            House(column: 0, row: 1, state: .occupied(.circle)),
            House(column: 0, row: 2, state: .occupied(.cross))
        ].allTheSamePlayer)
    }

    func testHousesAllSamePlayerFalseBecauseEmpty() {
        XCTAssertNil([
            House(column: 0, row: 0, state: .occupied(.cross)),
            House(column: 0, row: 1, state: .empty),
            House(column: 0, row: 2, state: .occupied(.cross))
        ].allTheSamePlayer)
    }
}
