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


// 미리 선언되어 있다고 하셨지만, 확인용으로 다시 첨부합니다.
struct StatefulPreviewWrapper2<Value1, Value2, Value3, Value4, Content: View>: View {
    @State private var value1: Value1
    @State private var value2: Value2
    @State private var value3: Value3
    @State private var value4: Value4
    private let content: (Binding<Value1>, Binding<Value2>, Binding<Value3>, Binding<Value4>) -> Content

    init(_ initialValues: (Value1, Value2, Value3, Value4),
         @ViewBuilder content: @escaping (Binding<Value1>, Binding<Value2>, Binding<Value3>, Binding<Value4>) -> Content) {
        _value1 = State(initialValue: initialValues.0)
        _value2 = State(initialValue: initialValues.1)
        _value3 = State(initialValue: initialValues.2)
        _value4 = State(initialValue: initialValues.3)
        self.content = content
    }

    var body: some View {
        content($value1, $value2, $value3, $value4)
    }
}
