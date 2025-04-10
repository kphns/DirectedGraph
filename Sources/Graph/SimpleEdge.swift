public struct SimpleEdge: Edge, Codable {
    public var source: SimpleNode
    public var target: SimpleNode
    public var value: Int
    public var weight: Float
    public var showHead: Bool = true
    
    public init(source: SimpleNode, target: SimpleNode, value: Int) {
        self.source = source
        self.target = target
        self.value = value
        self.weight = Float(value)
    }
}
