import SwiftUI

public extension View {
    func sizeReader(_ size: Binding<CGSize>) -> some View {
        SizeReader(size: size) {
            self
        }
    }
}

public struct SizeReader<Content: View>: View {
    @Binding var size: CGSize
    let content: () -> Content
    public var body: some View {
        ZStack {
            content()
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size = preferences
        }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
