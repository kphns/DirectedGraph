/// A node represents a vertex of the graph (a dot)
public protocol Node {
    associatedtype Identifier: Hashable
    var id: Identifier { get }
}
