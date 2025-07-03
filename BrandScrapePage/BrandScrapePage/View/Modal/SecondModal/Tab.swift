//
//  Tab.swift
//  BrandScrapePage
//
//  Created by 정태주 on 7/3/25.
//
import SwiftUI
// ✅ 탭 버튼 컴포넌트
@ViewBuilder
func TabButton(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
    Button(action: {
        withAnimation(.easeInOut(duration: 0.3)) {
            action()
        }
    }) {
        VStack(spacing: 0) {
            Spacer()
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(.black)
            Spacer()
        }
        .frame(height: selected ? 56 : 40)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 4)
        .background(
            Group {
                if selected {
                    TopRoundedRectangle(radius: 16)
                        .fill(Color(hex: "#C4D1FF").opacity(0.6))
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(hex: "#959595"))
                }
            }
        )
        .animation(.easeInOut(duration: 0.3), value: selected)
    }
}
