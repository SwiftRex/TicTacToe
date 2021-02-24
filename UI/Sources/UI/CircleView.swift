import SwiftUI

public struct CircleView: View {
    private let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Circle()
                .inset(by: UI.ElementWidth.half)
                .stroke(lineWidth: UI.ElementWidth.full)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


#if DEBUG
struct CircleViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            CircleView { }
        }
    }
}
#endif
