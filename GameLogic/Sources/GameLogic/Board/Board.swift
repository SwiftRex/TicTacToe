import Foundation

public struct Board: Equatable, CustomStringConvertible {
    public internal(set) var houses: [House]
    private let length: Int

    public init?(length: Int) {
        guard length > 0 else { return nil }
        self.length = length

        houses = (0 ..< length)
            .flatMap { row in
                (0 ..< length).map { column in
                    House(id: row * length + column + 1, column: column, row: row, state: .empty)
                }
            }
    }

    var rows: [Int: [House]] {
        Dictionary(grouping: houses) { house in
            house.row
        }
    }

    var columns: [Int: [House]] {
        Dictionary(grouping: houses) { house in
            house.column
        }
    }

    public var emptyHouses: [House] {
        houses.filter(\.state.isEmpty)
    }

    var diagonals: (topLeftToBottomRight: [House], topRightToBottomLeft: [House]) {
        let topLeftToBottomRight = houses.filter { $0.column == $0.row }
        let topRightToBottomLeft = houses.filter { length - 1 - $0.column == $0.row }
        return (topLeftToBottomRight: topLeftToBottomRight, topRightToBottomLeft: topRightToBottomLeft)
    }

    public var description: String {
        generateDescription(houseStringGenerator: \.state.description)
    }

    public var numberedBoard: String {
        generateDescription { house in
            house.state.isOccupied
                ? house.state.description
                : {
                    let number = "\(house.id)"
                    switch number.count {
                    case 0: return "   "
                    case 1: return " \(number) "
                    case 2: return " \(number)"
                    default: return "\(number)" // FIXME: yes, it's gonna break if more than 999 houses are shown. Fix me, or not.
                    }
                }()
        }
    }

    private func generateDescription(houseStringGenerator: (House) -> String) -> String {
        /*
         -------------
         | x |   |   |
         -------------
         |   | o |   |
         -------------
         |   |   | x |
         -------------
         */
        let dash = "-"
        let pipe = "|"
        let newLine = "\n"
        let columnBorders = length + 1
        let houseWidth = 3

        // How many dashes on the rowSeparator?
        // 1 column  = 1 * 3 + (1 + 1) = 5
        // 2 columns = 2 * 3 + (2 + 1) = 9
        // 3 columns = 3 * 3 + (3 + 1) = 13
        let rowSeparator = Array(repeating: dash, count: length * houseWidth + columnBorders).joined()

        let columnSeparator = pipe

        let rowsStrings = (0 ..< length).map { row in
            //  "|"
            // + ["   ", "   ", " x "] joined by pipe ( = "   |   | x ")
            // + "|"
            // = "|   |   | x |"
            [
                columnSeparator,
                (0 ..< length).map { column in
                    houses
                        .first { $0.column == column && $0.row == row }
                        .map(houseStringGenerator)
                    ?? ""
                }.joined(separator: columnSeparator),
                columnSeparator
            ].joined()
        }

        // Combine rows by \n-----\n, and surround by extra -----\n at the beginning and \n----- at the end
        return [rowSeparator, rowsStrings.joined(separator: newLine + rowSeparator + newLine), rowSeparator].joined(separator: newLine)
    }
}
