import Foundation
import GameLogic

func chooseAvatar() -> PlayerAvatar {
    while true {
        switch readLine() {
        case "x": return .cross
        case "o": return .circle
        case "q": exit(0)
        default:
            print("Invalid option. Wanna be 'x' or 'o'? ('q' to quit game)")
        }
    }
}

func chooseNumber() -> Int {
    while true {
        guard let number = readLine().flatMap(Int.init) else {
            print("Invalid option. Type a number.")
            continue
        }
        return number
    }
}

func iWannaPlayAGame() -> Bool {
    print("Wanna be 'x' or 'o'? ('q' to quit game)")
    let humanAvatar = chooseAvatar()
    print("Fine, you're '\(humanAvatar)', CPU is '\(humanAvatar.other)'")

    print("Who starts? 'x' or 'o'? ('q' to quit game)")
    let whoStarts = chooseAvatar()

    let humanPlayer = Player(avatar: humanAvatar, isHuman: true)
    let cpuPlayer = Player(avatar: humanAvatar.other, isHuman: false)
    let humanStarts = humanAvatar == whoStarts

    let game = Game(
        board: Board(length: 3)!,
        players: [
            Player(avatar: whoStarts, isHuman: humanStarts),
            Player(avatar: whoStarts.other, isHuman: !humanStarts)
        ]
    )

    print(board: game!.board)

    print("\(humanStarts ? "Your turn! Pick a number" : "CPU's turn! Wait while it decides...")")

    return false
}

while iWannaPlayAGame() { }

func print(board: Board) {
    board.numberedBoard.split(separator: "\n").forEach {
        print($0)
    }
}
