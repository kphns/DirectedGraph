import SwiftUI

public struct GraphView<NodeContent: View, EdgeContent: View, Graph: DirectedGraph.Graph>: View {
    @ObservedObject private var viewModel: GraphViewModel<Graph>
    @State private var currentOffset = CGSize.zero
    @State private var finalOffset = CGSize.zero
    @State private var scale: CGFloat = 1
    private let nodeContent: (Graph.NodeType) -> NodeContent
    private let edgeContent: (Graph.EdgeType) -> EdgeContent

    public init(_ viewModel: GraphViewModel<Graph>, @ViewBuilder nodeContent: @escaping (Graph.NodeType) -> NodeContent, @ViewBuilder edgeContent: @escaping (Graph.EdgeType) -> EdgeContent) {
        self.viewModel = viewModel
        self.nodeContent = nodeContent
        self.edgeContent = edgeContent
    }
    
    public var body: some View {
        let offset = finalOffset + currentOffset
        let scroll = DragGesture()
            .onChanged { gesture in
                self.currentOffset = gesture.translation / self.scale
        }
        .onEnded { _ in
            self.finalOffset = offset
            self.currentOffset = CGSize.zero
        }
        
        return ZStack {
            ForEach(viewModel.edges) { edge in
                EdgeView(viewModel: edge) {
                    self.edgeContent(edge.edge)
                }
            }
            
            ForEach(viewModel.nodes) { node in
                NodeView(viewModel: node) {
                    self.nodeContent(node.node)
                }
            }
        }
        .offset(offset)
        .scaleEffect(scale)
        .contentShape(Rectangle())
        .gesture(scroll)
        .scalable(initialScale: self.$scale, scaleRange: CGFloat(0.2)...5)
        .onAppear {
            self.viewModel.startLayout()
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    private static let nodes = [
        SimpleNode(id: "1", group: 0),
        SimpleNode(id: "2", group: 0),
        SimpleNode(id: "3", group: 1),
        SimpleNode(id: "4", group: 2)]
    
    private static let edges = [
        SimpleEdge(source: nodes[0], target: nodes[0], value: 5),
        SimpleEdge(source: nodes[0], target: nodes[1], value: 5),
        SimpleEdge(source: nodes[0], target: nodes[2], value: 1),
        SimpleEdge(source: nodes[2], target: nodes[3], value: 2),
        SimpleEdge(source: nodes[1], target: nodes[2], value: 1)
    ]
    
    static var previews: some View {
        GraphView(GraphViewModel(SimpleGraph(nodes: nodes,
                                             edges: edges)))
    }
}

public extension GraphView where NodeContent == DefaultNodeView, EdgeContent == DefaultEdgeView, Graph == SimpleGraph {
    init(_ viewModel: GraphViewModel<SimpleGraph>) {
        let count = viewModel.graphNodes.compactMap { $0.group }.countDistinct
        let palette = Palette(colorCount: count)
        self.init(viewModel, nodeContent: { node in
            DefaultNodeView(node: node, palette: palette)
        }, edgeContent: { edge in
            DefaultEdgeView(edge: edge)
        })
    }
}
