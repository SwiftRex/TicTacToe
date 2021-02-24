import SwiftUI

struct CrossShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: rect.origin)
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.move(to: .init(x: rect.maxX, y: rect.origin.y))
        path.addLine(to: .init(x: rect.origin.x, y: rect.maxY))
        return path
    }
}

public struct CrossView: View {
    private let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            CrossShape()
                .stroke(lineWidth: UI.ElementWidth.full)
                .padding(UI.Spaces.l)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#if DEBUG
struct CrossViewPreview: PreviewProvider {
    static var previews: some View {
        Group {
            CrossView { }
        }
    }
}
#endif
