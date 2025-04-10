import SwiftUI
import Combine

final class EdgeViewModel<Graph: DirectedGraph.Graph>: ObservableObject, Identifiable {
    typealias NodeType = Graph.NodeType
    typealias EdgeType = Graph.EdgeType
    
    let id: String
    let edge: EdgeType
    var weight: CGFloat { CGFloat(edge.weight) }
    @Published private var source: NodeViewModel<Graph>
    @Published private var target: NodeViewModel<Graph>
    @Published public var value: EdgeType.ValueType
    @Published var showValue = false
    var sourceCancellable: AnyCancellable?
    var targetCancellable: AnyCancellable?
    var showHead: Bool { edge.showHead }
    
    init(edge: EdgeType, source: NodeViewModel<Graph>, target: NodeViewModel<Graph>) {
        self.id = "\(source.id)-\(target.id)"
        self.edge = edge
        self.source = source
        self.target = target
        self.value = edge.value
        
        sourceCancellable = source.objectWillChange.sink { (_) in
            self.objectWillChange.send()
        }
        targetCancellable = target.objectWillChange.sink { (_) in
            self.objectWillChange.send()
        }
    }
    
    var middle: CGPoint {
        guard source.id != target.id else {
            return CGPoint(
                cos(Arrow.Constants.circularAngle.radians) * -Arrow.Constants.circularRadius,
                sin(Arrow.Constants.circularAngle.radians) * -Arrow.Constants.circularRadius)
            + start
        }
        return (source.position + target.position) / 2
    }
    
    var start: CGPoint {
        source.position
    }
    
    var end: CGPoint? {
        guard source.id != target.id else { return nil }
        let delta = target.position - start
        let angle = delta.angle
        let suppr = CGPoint(x: cos(angle) * (target.size.width + weight) * 0.5, y: sin(angle) * (target.size.height + weight) * 0.5)
        return target.position - suppr
    }
}
