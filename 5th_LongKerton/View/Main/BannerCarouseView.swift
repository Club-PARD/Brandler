//
//  BannerCarouseView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/3/25.
//

import SwiftUI

struct BannerCarouselView: View {
    @ObservedObject private var session = UserSessionManager.shared

    var banners: [Banner]
    @State private var currentIndex = 1 // 💡 진짜 첫 배너는 index 1
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    private var loopedBanners: [Banner] {
        guard let first = banners.first, let last = banners.last else { return [] }
        return [last] + banners + [first] // 앞뒤로 가짜 추가
    }

    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack{
                HStack{
                    //Text("장마엔 종로룩 완성")
                    Text(UserSessionManager.shared.userData?.nickname ?? "장마엔 로그인")
                        .foregroundColor(Color("BannerHeadTextColor"))
                        .font(.custom("Pretendard-Medium.ttf",size: 13))
                        .font(.system(size:13,weight:.medium))
                    Text("님 반가워요")
                        .foregroundColor(Color("BannerHeadTextColor"))
                        .font(.custom("Pretendard-Medium.ttf",size: 13))
                        .font(.system(size:13,weight:.light))
                    Spacer()
                }
                
                SwiftUI.TabView(selection: $currentIndex) {
                    ForEach(Array(loopedBanners.enumerated()), id: \.offset) { index, banner in
                        BannerCardView(
                            banner: banner,
                            index: realIndex(for: index),
                            total: banners.count
                        )
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 160)
                .onReceive(timer) { _ in
                    withAnimation {
                        currentIndex += 1
                    }
                }
                .onChange(of: currentIndex) { oldIndex, newIndex in
                    if newIndex == loopedBanners.count - 1 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.none) {
                                currentIndex = 1 // 처음으로 점프
                            }
                        }
                    } else if newIndex == 0 {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.none) {
                                currentIndex = loopedBanners.count - 2 // 마지막으로 점프
                            }
                        }
                    }
                }
                .onAppear {
                    currentIndex = 1 // 진짜 첫 배너부터 시작
                }
                .onDisappear {
                    timer.upstream.connect().cancel()
                }
            }
            .padding(.top,26)
            .padding(.trailing,5)
            Image("MainBannerSplash")
                .resizable()
                .scaledToFit()
                .foregroundColor(.clear)
                .frame(width: 88, height: 70)
        }
    }

    /// 진짜 index (가짜 앞/뒤 제거한 index)
    private func realIndex(for index: Int) -> Int {
        let count = banners.count
        switch index {
        case 0:
            return count - 1
        case count + 1:
            return 0
        default:
            return index - 1
        }
    }
}

