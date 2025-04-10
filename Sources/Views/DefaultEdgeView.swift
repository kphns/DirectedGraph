//
//  SwiftUIView.swift
//  DirectedGraph
//
//  Created by Karsten Huneycutt on 4/10/25.
//

import SwiftUI

public struct DefaultEdgeView: View {
    let edge: SimpleEdge
    
    public var body: some View {
        Text("\(edge.value)")
            .font(.caption)
    }
}

