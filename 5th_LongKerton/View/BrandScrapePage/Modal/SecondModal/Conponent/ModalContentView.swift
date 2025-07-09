//import SwiftUI
//
//struct ModalContentView: View {
//    let selectedTab: Int
//    @ObservedObject var viewModel: BrandViewModel
//    
//    var body: some View {
//        VStack(spacing: 10) {
//            Spacer()
//            
//            Text(
//                selectedTab == 0
//                ? "고래를 발견할수록 당신의 바다는 더 깊어집니다. \n 취향의 지도를 확장해 보세요."
//                : "디깅 수에 따라 고래가 자라납니다."
//            )
//            .font(.custom("Pretendard-Medium", size: 12))
//            .foregroundColor(Color.TabPurple)
//            .multilineTextAlignment(.center)
//            .frame(maxWidth: .infinity)
//            
//            VStack(spacing: 10) {
//                ForEach(1...5, id: \.self) { step in
//                    Rectangle()
//                        .fill(Color.LogBlue)
//                        .frame(width: 360, height: 1)
//                    
//                    stepView(for: step)
//                }
//            }
//        }
//        .background(Color.ContentBackground.opacity(0.6))
//        .mask(
//            CustomRoundedCorner(
//                radius: 16,
//                corners: cornersForTab()
//            )
//        )
//        .overlay(
//            GeometryReader { geo in
//                CustomRoundedCornerWithFixedGap(
//                    radius: 16,
//                    corners: cornersForTab(),
//                    gapStartX: gapStartX(in: geo.size.width),
//                    gapEndX: gapEndX(in: geo.size.width)
//                )
//                .stroke(Color.LogBlue, lineWidth: 1)
//            }
//        )
//        .frame(maxWidth: .infinity)
//    }
//    
//    @ViewBuilder
//    private func stepView(for step: Int) -> some View {
//        if selectedTab == 0 {
//            DiggingStepView(
//                step: step,
//                progress: viewModel.progress(for: step),
//                diggingDistanceInKM: viewModel.diggingDistanceInKM
//            )
//        } else {
//            BrandStepView(step: step)
//        }
//    }
//    
//    private func cornersForTab() -> [Corner] {
//        var result: [Corner] = [.bottomLeft, .bottomRight]
//        if selectedTab == 0 {
//            result.append(.topRight)
//        } else {
//            result.append(.topLeft)
//        }
//        return result
//    }
//    
//    private func gapStartX(in width: CGFloat) -> CGFloat {
//        let tabWidth: CGFloat = 160
//        let tabPadding: CGFloat = 25
//        let diggerOffset: CGFloat = -4
//        let brandOffset: CGFloat = 6
//        
//        if selectedTab == 0 {
//            return tabPadding + diggerOffset - 20
//        } else {
//            return width - tabPadding - tabWidth + brandOffset + 5
//        }
//    }
//    
//    private func gapEndX(in width: CGFloat) -> CGFloat {
//        let tabWidth: CGFloat = 160
//        let tabPadding: CGFloat = 25
//        let diggerOffset: CGFloat = -4
//        let brandOffset: CGFloat = 6
//        
//        if selectedTab == 0 {
//            return tabPadding + tabWidth + diggerOffset - 5
//        } else {
//            return width - tabPadding + brandOffset + 19
//        }
//    }
//}
