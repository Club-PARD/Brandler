import SwiftUI

// 🔸 스크롤 오프셋을 전달하기 위한 PreferenceKey 정의
struct ScrollOffsetKey: PreferenceKey {
    
    // 🔹 기본값 설정 (초기 오프셋은 0)
    static var defaultValue: CGFloat = 0
    
    // 🔹 여러 값이 전달될 때, 마지막 값으로 갱신
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
