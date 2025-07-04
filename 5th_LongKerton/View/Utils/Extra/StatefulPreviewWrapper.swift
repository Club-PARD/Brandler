//
//  StatefulPreviewWrapper.swift
//  BrandPage
//
//  Created by 정태주 on 7/2/25.
//

// ✅ Utils/StatefulPreviewWrapper.swift
import SwiftUI

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
