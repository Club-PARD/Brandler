//
//  ScrollOffsetReader.swift
//  BrandPage
//
//  Created by 정태주 on 7/4/25.
//

import SwiftUI

// 🔸 스크롤 오프셋을 추적하는 뷰
struct ScrollOffsetReader: View {
    var coordinateSpace: String // 추적할 좌표계 이름
    var onOffsetChange: (CGFloat) -> Void // 오프셋 변경 시 호출할 콜백

    var body: some View {
        GeometryReader { geo in // 현재 뷰의 위치를 읽음
            Color.clear // 화면에는 보이지 않음
                .preference( // 위치 값을 preference로 상위에 전달
                    key: ScrollOffsetPreferenceKey.self,
                    value: geo.frame(in: .named(coordinateSpace)).minY
                )
        }
        .frame(height: 0) // 실제 렌더링 영역은 없음
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            onOffsetChange(-value) // 값 변경 시 콜백 실행 (음수 변환하여 위로 스크롤 시 양수)
        }
    }
}

// 🔸 PreferenceKey 정의 (오프셋을 추적하기 위한 키)
private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0 // 기본값은 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue() // 최신 값으로 갱신
    }
}
