//
//  Helper.swift
//  5th_LongKerton
//
//  Created by 정태주 on 7/9/25.
//
import SwiftUI


struct OverlayHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
