/// A graph is a collection of nodes and edges between the nodes
public protocol Graph {
    associatedtype NodeType: Node
    associatedtype EdgeType: Edge where EdgeType.NodeType == NodeType
    
    var nodes: [NodeType] { get }
    var edges: [EdgeType] { get }
}
