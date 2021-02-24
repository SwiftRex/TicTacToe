import CoreGraphics
import Foundation

public enum UI {
    public enum Spaces {
        public static let none: CGFloat = 0
        public static let xs: CGFloat = 2
        public static let s: CGFloat = 4
        public static let m: CGFloat = 8
        public static let l: CGFloat = 12
        public static let xl: CGFloat = 16
    }

    public enum ElementWidth {
        public static var half: CGFloat { full / 2 }
        public static let full: CGFloat = 14
    }
}
