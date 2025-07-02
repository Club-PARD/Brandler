//
//  ContentView.swift
//  BSPModal
//
//  Created by 정태주 on 6/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showSecondModal = false
    @State private var offsetY: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()

            VStack {
                Spacer()
                Button(action: {
                    showSecondModal = true
                }) {
                    Text("두 번째 모달 열기")
                        .foregroundColor(.white) // 혹은 원하는 색
                        .underline() // 선택 사항
                }
                .buttonStyle(.plain) // 탭 효과 제거 (텍스트만 보이게)
                Spacer()
            }

            // 첫 번째 모달
            FirstBottomSheetView(
                offsetY: $offsetY,
                dragOffset: dragOffset
            )

            // 두 번째 모달
            if showSecondModal {
                SecondModalView(isVisible: $showSecondModal)
            }
        }
        .animation(.easeInOut, value: showSecondModal)
    }
}

#Preview {
    ContentView()
}
