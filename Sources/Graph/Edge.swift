/// An edge is the directed link between two nodes
public protocol Edge {
    associatedtype NodeType: Node
    associatedtype ValueType
    var source: NodeType { get }
    var target: NodeType { get }
    var value: ValueType { get }
    var weight: Float { get }
    var showHead: Bool { get }
}
