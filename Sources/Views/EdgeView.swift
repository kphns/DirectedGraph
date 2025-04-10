import SwiftUI
import Combine

struct EdgeView<Graph: DirectedGraph.Graph, Content: View>: View {
    @ObservedObject var viewModel: EdgeViewModel<Graph>
    private let content: () -> Content

    public init(viewModel: EdgeViewModel<Graph>, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }

    var body: some View {
        ZStack {
            Arrow(start: viewModel.start, end: viewModel.end, thickness: viewModel.weight, showHead: viewModel.showHead)
                .foregroundColor(.gray)
                .opacity(0.5)
            
            if viewModel.showValue {
                content()
                    .position(viewModel.middle)
            }
        }
    }
}
