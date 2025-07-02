import SwiftUI

struct ScrollHideTabBarView: View {
    @StateObject private var scrollManager = ScrollDirectionManager()

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                // ✅ offset 측정을 위해 이 위치에서만 GeometryReader 사용
                VStack(spacing: 0) {
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self,
                                        value: geo.frame(in: .global).minY)
                    }
                    .frame(height: 0)

                    ForEach(0..<50, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.3))
                            .frame(height: 100)
                            .overlay(Text("Item \(i)").foregroundColor(.black))
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    }

                    Spacer().frame(height: 100) // 탭바와 겹치지 않게
                }
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                scrollManager.updateScroll(offset: value)
            }

            CustomTabBar()
                .offset(y: scrollManager.isTabBarHidden ? 100 : 0)
                .animation(.easeInOut(duration: 0.3), value: scrollManager.isTabBarHidden)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    ScrollHideTabBarView()
}
