import SwiftUI

public struct AvailableHouseView: View {
    private let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Color(red: 0.9, green: 0.9, blue: 0.9)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
