import SwiftUI
import Combine

final class NodeViewModel<Graph: DirectedGraph.Graph>: ObservableObject, Identifiable {
    typealias NodeType = Graph.NodeType
    let node: NodeType
    let id: NodeType.Identifier
    @Published var interactive = false
    @Published var position: CGPoint
    @Published var size: CGSize
    var velocity: CGPoint
    
    init(_ node: NodeType) {
        self.node = node
        id = node.id
        position = .zero
        velocity = .zero
        size = .zero
    }
}
