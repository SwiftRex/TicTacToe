import CombineRex
import Foundation
import SwiftUI

public enum BoardViewAction {
    case onAppear
    case tap(column: Int, row: Int)
}

public struct BoardViewState: Equatable {
    public init(houses: [BoardViewState.HouseState]) {
        self.houses = houses
    }

    public let houses: [HouseState]

    public struct HouseState: Hashable, Identifiable {
        public init(column: Int, row: Int, occupancy: BoardViewState.RowType?) {
            self.column = column
            self.row = row
            self.occupancy = occupancy
        }

        public var id: HouseState { self }
        public let column: Int
        public let row: Int
        public let occupancy: RowType?

        public func hash(into hasher: inout Hasher) {
            hasher.combine(column)
            hasher.combine(row)
        }
    }

    public enum RowType: Equatable {
        case x, o
    }

    public static var empty: BoardViewState { .init(houses: []) }
}

public struct BoardView: View {
    private let viewModel: ObservableViewModel<BoardViewAction, BoardViewState>

    public init(viewModel: ObservableViewModel<BoardViewAction, BoardViewState>) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack(spacing: UI.Spaces.none) {
            ForEach(0 ... (viewModel.state.houses.map(\.row).max() ?? 0), id: \.self) { row in
                if row > 0 {
                    Rectangle().frame(height: UI.ElementWidth.full)
                }

                HStack(spacing: 0) {
                    ForEach(0 ... (viewModel.state.houses.map(\.column).max() ?? 0), id: \.self) { column in
                        if column > 0 {
                            Rectangle().frame(width: UI.ElementWidth.full)
                        }

                        switch viewModel.state.houses.first(where: { $0.column == column && $0.row == row })?.occupancy {
                        case .x?:
                            CrossView { viewModel.dispatch(.tap(column: column, row: row)) }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .padding(UI.Spaces.l)
                        case .o?:
                            CircleView { viewModel.dispatch(.tap(column: column, row: row)) }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .padding(UI.Spaces.l)
                        case nil:
                            AvailableHouseView { viewModel.dispatch(.tap(column: column, row: row)) }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .padding(UI.Spaces.l)
                        }
                    }
                }
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .onAppear { viewModel.dispatch(.onAppear) }
    }
}

#if DEBUG
struct BoardViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            BoardView(viewModel: .mock(state: .init(houses: [
                .ID(column: 0, row: 0, occupancy: .x), .ID(column: 1, row: 0, occupancy: .none), .ID(column: 2, row: 0, occupancy: .none),
                .ID(column: 0, row: 1, occupancy: .o), .ID(column: 1, row: 1, occupancy: .x), .ID(column: 2, row: 1, occupancy: .x),
                .ID(column: 0, row: 2, occupancy: .none), .ID(column: 1, row: 2, occupancy: .o), .ID(column: 2, row: 2, occupancy: .none)
            ])))
        }
    }
}
#endif
