import CombineRex
import SwiftRex
import SwiftUI
import UI

@main
struct TicTacToeApp: App {
    @StateObject var store = Store(world: .production).asObservableViewModel(initialState: .empty)

    var body: some Scene {
        WindowGroup {
            BoardView(
                viewModel: store
                    .projection(
                        action: { viewAction in
                            switch viewAction {
                            case .onAppear:
                                return .game(.start(length: 3, players: [Player(avatar: .cross, isHuman: true), Player(avatar: .circle, isHuman: false)]))
                            case let .tap(column, row):
                                return .game(.turn(.turnAttempt(player: .init(avatar: .cross, isHuman: true), column: column, row: row)))
                            }
                        },
                        state: { state in
                            BoardViewState(
                                houses: (state.game?.board.houses ?? []).map { house in
                                    BoardViewState.HouseState(column: house.column, row: house.row, occupancy: {
                                        switch house.state {
                                        case let .occupied(player) where player.avatar == .cross:
                                            return .x
                                        case let .occupied(player) where player.avatar == .circle:
                                            return .o
                                        default:
                                            return .none
                                        }
                                    }())
                                }
                            )
                        }
                    )
                    .asObservableViewModel(initialState: .empty)
            )
            EmptyView()
        }
    }
}

import CoreML

struct World {
    let random: AnyRandomNumberGenerator
    let ai: ProbabilityCalculator
}

extension World {
    private static let ai = TicTacToeAI()

    static let production: World = .init(
        random: AnyRandomNumberGenerator(SystemRandomNumberGenerator()),
        ai: ProbabilityCalculator { board in
            Result {
                guard let multiArray = convertToMLArray(board) else {
                    throw NSError(domain: "Invalid board input, it can't be represented as MLMultiArray", code: -1, userInfo: nil)
                }
                let result = try ai.prediction(board_state: multiArray)
                guard result.winning_probability.count > 0 else {
                    throw NSError(domain: "Invalid prediction output, MLMultiArray couldn't be converted to winning probability", code: -1, userInfo: nil)
                }
                return result.winning_probability[0].doubleValue
            }
        }
    )

    private static func convertToMLArray(_ array: [Int]) -> MLMultiArray? {
        let arr = try? MLMultiArray(shape: [1,1,9], dataType: MLMultiArrayDataType.float32)

        for i in 0 ..< array.count {
            arr?[i] = NSNumber(value: array[i])
        }
        return arr
    }
}

import DumbOpponent
import GameLogic
import IntelligentOpponent

class Store: ReduxStoreBase<AppAction, AppState> {
    init(world: World) {
        let middleware =
//            SymmetricalEffectMiddleware<TurnAction, Game?, AnyRandomNumberGenerator>
//                .dumbOpponent
//                .lift(inputAction: \.game?.turn, outputAction: { AppAction.game(.turn($0)) }, state: \AppState.game)
//                .inject(world.random).eraseToAnyMiddleware()

            SymmetricalEffectMiddleware<TurnAction, Game?, ProbabilityCalculator>
                .intelligentOpponent
                .lift(inputAction: \.game?.turn, outputAction: { AppAction.game(.turn($0)) }, state: \AppState.game)
                .inject(world.ai).eraseToAnyMiddleware()

            <> GameLogic.Module.middleware.lift(action: \.game, state: \AppState.game).eraseToAnyMiddleware()

        let reducer = GameLogic.Module.reducer.lift(action: \AppAction.game, state: \AppState.game)

        super.init(
            subject: .combine(initialValue: .empty),
            reducer: reducer,
            middleware: middleware
        )
    }
}

struct AppState: Equatable {
    var game: Game?

    static var empty: AppState {
        .init(game: nil)
    }
}

enum AppAction {
    case game(GameAction)
}

extension AppAction {
    public var game: GameAction? {
        get {
            guard case let .game(value) = self else { return nil }
            return value
        }
        set {
            guard case .game = self, let newValue = newValue else { return }
            self = .game(newValue)
        }
    }

    public var isGame: Bool {
        self.game != nil
    }
}
