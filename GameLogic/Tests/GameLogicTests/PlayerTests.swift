import GameLogic
import XCTest

class PlayerTests: XCTestCase {
    func testPlayerRawStrings() {
        XCTAssertEqual(Player.cross.rawValue, "x")
        XCTAssertEqual(Player.circle.rawValue, "o")
    }

    func testPlayerDescriptions() {
        XCTAssertEqual(Player.cross.description, "x")
        XCTAssertEqual(Player.circle.description, "o")
    }

    func testOtherPlayerFromCross() {
        XCTAssertEqual(Player.cross.other, .circle)
    }

    func testOtherPlayerFromCircle() {
        XCTAssertEqual(Player.circle.other, .cross)
    }

    func testOtherPlayerTwiceFromCross() {
        XCTAssertEqual(Player.cross.other.other, .cross)
    }

    func testOtherPlayerTwiceFromCircle() {
        XCTAssertEqual(Player.circle.other.other, .circle)
    }
}
