import Foundation

extension Collection {
    /// Safely get the item at the given index. If the index is out-of-bounds, it will return nil
    ///
    /// - Parameter index: element index
    /// - Returns: element at the given index or nil if wrong index was provided.
    public subscript(safe index: Index) -> Element? {
        get {
            return inBounds(index) ? self[index] : nil
        }
    }

    fileprivate func inBounds(_ index: Index) -> Bool {
        return index < endIndex && index >= startIndex
    }
}

extension MutableCollection {
    /// Safely get or set the item at the given index. If the index is out-of-bounds, it will return nil
    ///
    /// - Parameter index: element index
    /// - Returns: element at the given index or nil if wrong index was provided.
    public subscript(safe index: Index) -> Element? {
        get {
            return inBounds(index) ? self[index] : nil
        }
        set {
            guard inBounds(index), let newValue = newValue else { return }
            self[index] = newValue
        }
    }
}

extension RangeReplaceableCollection {

    /// Safely remove the item at the given index and return it.
    /// If the index is out-of-bounds, array won't be modified and the return will be nil.
    ///
    /// - Parameter index: element index
    /// - Returns: element removed or nil if wrong index was provided.
    @discardableResult
    public mutating func removeSafe(at index: Index) -> Element? {
        guard let item = self[safe: index] else { return nil }
        remove(at: index)
        return item
    }
}
