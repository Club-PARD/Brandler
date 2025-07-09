//import SwiftUI
//// ✅ 단계 가이드 모달 뷰
//struct SecondModalView: View {
//    @Binding var isVisible: Bool // 모달 표시 여부를 바인딩
//    @GestureState private var dragOffset: CGFloat = 0 // 드래그 변화 감지용 상태
//    @State private var offsetY: CGFloat = UIScreen.main.bounds.height // 현재 Y 위치 (초기엔 화면 아래)
//    @State private var selectedTab = 0 // 선택된 탭 인덱스 (0: 디깅러, 1: 브랜드)
//    @StateObject private var viewModel = BrandViewModel() // 브랜드 데이터 상태 관리
//
//    var body: some View {
//        GeometryReader { geometry in // 화면 크기 측정을 위한 GeometryReader
//            let screenHeight = geometry.size.height // 전체 화면 높이
//            let maxHeight = screenHeight * 0.95 // 모달 최대 높이
//            let openOffset = screenHeight - maxHeight // 모달이 열릴 위치
//            let closeThreshold = screenHeight * 0.6 // 모달이 닫히는 임계값
//
//            ZStack(alignment: .center){
//                // ✅ 뒷배경 (모달 표시 시만 나타남)
//                if isVisible {
//                    Color.black.opacity(0.6) // 어두운 반투명 배경
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            slideDownAndClose(to: screenHeight) // 배경 탭하면 닫힘
//                        }
//
//                    VStack(spacing: 0) {
//                        // ✅ 상단 닫기 버튼
//                        HStack {
//                            Button(action: {
//                                slideDownAndClose(to: screenHeight)
//                            }) {
//                                Image(systemName: "xmark")
//                                    .foregroundColor(.white)
//                                    .padding()
//                            }
//                            Spacer()
//                        }
//
//                        // ✅ 모달 타이틀
//                        VStack(spacing: 0) {
//                            Text("단계 가이드")
//                                .font(.custom("Pretendard-SemiBold", size:15))
//                                .foregroundColor(.white)
//                        }
//                        .padding(.bottom, 12)
//                        .offset(y: -25)
//                        
//                        // ✅ 모달 내부 콘텐츠 영역
//                        ScrollView {
//                            VStack(spacing: 0) {
//                                // ✅ 탭 버튼 (디깅러 / 브랜드)
//                                HStack(alignment: .top, spacing: 8) {
//                                    TabButton(title: "디깅러", selected: selectedTab == 0) {
//                                        selectedTab = 0
//                                    }
//                                    TabButton(title: "브랜드", selected: selectedTab == 1) {
//                                        selectedTab = 1
//                                    }
//                                }
//                                .font(.custom("Pretendard-Medium", size:12))
//                                .padding(.horizontal, 19)
//                                .frame(height: 56)
//                                .padding(.top, 20)
//                                .foregroundColor(Color.white)
////                                .border(.red,width:1) // 탭바
////                                .offset(y: -5)
//
//                                // ✅ 설명 텍스트 + 단계 카드 뷰
//                                VStack(spacing: 10) {
//                                    Spacer()
//
//                                    Text(
//                                        selectedTab == 0 ?
//                                        "고래를 발견할수록 당신의 바다는 더 깊어집니다. \n 취향의 지도를 확장해 보세요." :
//                                        "디깅 수에 따라 고래가 자라납니다."
//                                    )
//                                    .font(.custom("Pretendard-Medium", size:12))
//                                    .foregroundColor(Color.TabPurple)
//                                    .multilineTextAlignment(.center)
//                                    .frame(maxWidth: .infinity)
////                                    .border(.red,width:1) // 부제목 영역
//
//                                    // ✅ 단계 카드
//                                    VStack(spacing: 10) {
//                                        if selectedTab == 0 {
//                                            ForEach(1...5, id: \.self) { step in
//                                                Rectangle()
//                                                    .fill(Color.LogBlue)
//                                                    .frame(width: 360, height: 1)
//                                                DiggingStepView(
//                                                    step: step,
//                                                    progress: viewModel.progress(for: step),
//                                                    diggingDistanceInKM: viewModel.diggingDistanceInKM
//                                                )
//                                            }
//                                        } else {
//                                            ForEach(1...5, id: \.self) { step in
//                                                Rectangle()
//                                                    .fill(Color.LogBlue)
//                                                    .frame(width: 360, height: 1)
//                                                BrandStepView(step: step)
//                                            }
//                                        }
//                                        
//                                    }
//                                }
//                                .background(Color.ContentBackground.opacity(0.6))
//                                .mask(
//                                    // ✅ 둥근 마스크 (탭에 따라 다르게)
//                                    CustomRoundedCorner(
//                                        radius: 16,
//                                        corners: {
//                                            var result: [Corner] = [.bottomLeft, .bottomRight]
//                                            if selectedTab == 0 {
//                                                result.append(.topRight)
//                                            } else {
//                                                result.append(.topLeft)
//                                            }
//                                            return result
//                                        }()
//                                    )
//                                )
//                                .overlay(
//                                    // ✅ 테두리 라인 - 탭 영역 gap 제외하고 그림
//                                    GeometryReader { geo in
//                                        let tabWidth: CGFloat = 160
//                                        let tabPadding: CGFloat = 25
//
//                                        let gapStartX: CGFloat
//                                        let gapEndX: CGFloat
//
//                                        let diggerOffset: CGFloat = -4
//                                        let brandOffset: CGFloat = 6
//
//                                        if selectedTab == 0 {
//                                            gapStartX = tabPadding + diggerOffset - 20
//                                            gapEndX = tabPadding + tabWidth + diggerOffset - 5
//                                        } else {
//                                            gapStartX = geo.size.width - tabPadding - tabWidth + brandOffset + 5
//                                            gapEndX = geo.size.width - tabPadding + brandOffset + 19
//                                        }
//
//                                        return AnyView(
//                                            CustomRoundedCornerWithFixedGap(
//                                                radius: 16,
//                                                corners: {
//                                                    var result: [Corner] = [.bottomLeft, .bottomRight]
//                                                    if selectedTab == 0 {
//                                                        result.append(.topRight)
//                                                    } else {
//                                                        result.append(.topLeft)
//                                                    }
//                                                    return result
//                                                }(),
//                                                gapStartX: gapStartX,
//                                                gapEndX: gapEndX
//                                            )
//                                            .stroke(Color.LogBlue, lineWidth: 1)
//                                        )
//                                    }
//                                )
//                                .frame(maxWidth: .infinity)
//                                .padding(.horizontal, 19)
//                            }
//                            .frame(maxWidth: .infinity, alignment: .center)
//
//                            Spacer().frame(height: 150) // 하단 여백
//                        }
//                        .ignoresSafeArea(.container, edges: .bottom)
//
//                        Spacer()
//                    }
//                    
//                    .frame(width: geometry.size.width - 30, height: maxHeight)
//                    .background(
//                        LinearGradient(
//                            gradient: Gradient(colors: [
//                                Color.ModalBackground1,
//                                Color.ModalBackground2,
//                                Color.ModalBackground3
//                            ]),
//                            startPoint: .top,
//                            endPoint: .bottom
//                        )
//                        .opacity(0.2)
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 30))
//                    .offset(y: offsetY + dragOffset)
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .gesture(
//                        // ✅ 드래그 제스처 처리
//                        DragGesture()
//                            .updating($dragOffset) { value, state, _ in
//                                state = value.translation.height
//                            }
//                            .onEnded { value in
//                                let newOffset = offsetY + value.translation.height
//                                if newOffset > closeThreshold {
//                                    slideDownAndClose(to: screenHeight)
//                                } else {
//                                    withAnimation { offsetY = openOffset }
//                                }
//                            }
//                    )
//                    .onAppear {
//                        // ✅ 처음 등장 시 애니메이션으로 등장
//                        withAnimation { offsetY = openOffset }
//                    }
//                    .transition(.move(edge: .bottom)) // 아래에서 등장
//                    .zIndex(10)
//                }
//            }
//            .ignoresSafeArea(.container, edges: .bottom)
//        }
//    }
//
//    // ✅ 모달을 닫는 함수 (애니메이션 + isVisible false)
//    private func slideDownAndClose(to screenHeight: CGFloat) {
//        withAnimation { offsetY = screenHeight }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            isVisible = false
//        }
//    }
//}
//
//// ✅ 프리뷰 테스트용 뷰 (배경 포함)
//struct SecondModalPreviewWrapper: View {
//    @State private var isVisible = true
//
//    var body: some View {
//        ZStack {
//            Image("whaleBackground")
//                .resizable()
//                .scaledToFit()
//                .edgesIgnoringSafeArea(.all)
//
//            Button("모달 열기") {
//                isVisible = true
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(10)
//
//            SecondModalView(isVisible: $isVisible)
//        }
//    }
//}
//
//#Preview {
//    SecondModalPreviewWrapper()
//}
import SwiftUI

struct SecondModalView: View {

    @Binding var isVisible: Bool // 모달 표시 여부를 바인딩
    @GestureState private var dragOffset: CGFloat = 0 // 드래그 변화 감지용 상태
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height // 현재 Y 위치 (초기엔 화면 아래)
    @State private var selectedTab = 0 // 선택된 탭 인덱스 (0: 디깅러, 1: 브랜드)
    @StateObject private var viewModel = BrandViewModel() // 브랜드 데이터 상태 관리
    
    var body: some View {
        GeometryReader { geometry in // 화면 크기 측정을 위한 GeometryReader
            let screenHeight = geometry.size.height // 전체 화면 높이
            let maxHeight = screenHeight * 0.95 // 모달 최대 높이
            let openOffset = screenHeight - maxHeight // 모달이 열릴 위치
            let closeThreshold = screenHeight * 0.6 // 모달이 닫히는 임계값
            
            ZStack(alignment: .center){
                // ✅ 뒷배경 (모달 표시 시만 나타남)
                if isVisible {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            slideDownAndClose(to: screenHeight)
                        }

                    
                    VStack(spacing: 0) {
                        // ✅ 상단 닫기 버튼
                        HStack {
                            Button(action: {
                                slideDownAndClose(to: screenHeight)
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            Spacer()
                        }
                        // ✅ 모달 타이틀
                        VStack(spacing: 0) {
                            Text("단계 가이드")
                                .font(.custom("Pretendard-SemiBold", size:15))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 12)
                        .offset(y: -25)
                        // ✅ 모달 내부 콘텐츠 영역
                        ScrollView {
                            VStack(spacing: 0) {
                                // ✅ 탭 버튼 (디깅러 / 브랜드)
                                HStack(alignment: .top, spacing: 8) {
                                    TabButton(title: "디깅러", selected: selectedTab == 0) {
                                        selectedTab = 0
                                    }
                                    TabButton(title: "브랜드", selected: selectedTab == 1) {
                                        selectedTab = 1
                                    }
                                }
                                .font(.custom("Pretendard-Medium", size:12))
                                .padding(.horizontal, 19)
                                .frame(height: 56)
                                .padding(.top, 20)
                                .foregroundColor(Color.white)
 
                                // ✅ 설명 텍스트 + 단계 카드 뷰
                                VStack(spacing: 10) {
                                    Spacer()
                                    
                                    Text(
                                        selectedTab == 0 ?
                                        "고래를 발견할수록 당신의 바다는 더 깊어집니다. \n 취향의 지도를 확장해 보세요." :
                                            "디깅 수에 따라 고래가 자라납니다."
                                    )
                                    .font(.custom("Pretendard-Medium", size:12))
                                    .foregroundColor(Color.TabPurple)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                    // ✅ 단계 카드
                                    VStack(spacing: 10) {
                                        if selectedTab == 0 {
                                            ForEach(1...5, id: \.self) { step in
                                                Rectangle()
                                                    .fill(Color.LogBlue)
                                                    .frame(width: 360, height: 1)
                                                DiggingStepView(
                                                    step: step,
                                                    progress: viewModel.progress(for: step),
                                                    diggingDistanceInKM: viewModel.diggingDistanceInKM
                                                )
                                            }
                                        } else {
                                            ForEach(1...5, id: \.self) { step in
                                                Rectangle()
                                                    .fill(Color.LogBlue)
                                                    .frame(width: 360, height: 1)
                                                BrandStepView(step: step)
                                            }
                                        }
                                        
                                    }
                                }
                                .background(Color.ContentBackground.opacity(0.6))
                                .mask(
                                    // ✅ 둥근 마스크 (탭에 따라 다르게)
                                    CustomRoundedCorner(
                                        radius: 16,
                                        corners: {
                                            var result: [Corner] = [.bottomLeft, .bottomRight]
                                            if selectedTab == 0 {
                                                result.append(.topRight)
                                            } else {
                                                result.append(.topLeft)
                                            }
                                            return result
                                        }()
                                    )
                                )
                                .overlay(
                                    // ✅ 테두리 라인 - 탭 영역 gap 제외하고 그림
                                    GeometryReader { geo in
                                        let tabWidth: CGFloat = 160
                                        let tabPadding: CGFloat = 25
                                        
                                        let gapStartX: CGFloat
                                        let gapEndX: CGFloat
                                        
                                        let diggerOffset: CGFloat = -4
                                        let brandOffset: CGFloat = 6
                                        
                                        if selectedTab == 0 {
                                            gapStartX = tabPadding + diggerOffset - 20
                                            gapEndX = tabPadding + tabWidth + diggerOffset - 5
                                        } else {
                                            gapStartX = geo.size.width - tabPadding - tabWidth + brandOffset + 5
                                            gapEndX = geo.size.width - tabPadding + brandOffset + 19
                                        }
                                        
                                        return AnyView(
                                            CustomRoundedCornerWithFixedGap(
                                                radius: 16,
                                                corners: {
                                                    var result: [Corner] = [.bottomLeft, .bottomRight]
                                                    if selectedTab == 0 {
                                                        result.append(.topRight)
                                                    } else {
                                                        result.append(.topLeft)
                                                    }
                                                    return result
                                                }(),
                                                gapStartX: gapStartX,
                                                gapEndX: gapEndX
                                            )
                                            .stroke(Color.LogBlue, lineWidth: 1)
                                        )
                                    }
                                 
                                )
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 19)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                       
                            Spacer().frame(height: 150) // 하단 여백
                        }
                        .ignoresSafeArea(.container, edges: .bottom)
                        
                        
                        Spacer()
                    }
                    
                    .frame(width: geometry.size.width - 30, height: maxHeight)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.ModalBackground1,
                                Color.ModalBackground2,
                                Color.ModalBackground3
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .opacity(0.2)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .offset(y: offsetY + dragOffset)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .gesture(
                        // ✅ 드래그 제스처 처리
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation.height
                            }
                            .onEnded { value in
                                let newOffset = offsetY + value.translation.height
                                if newOffset > closeThreshold {
                                    slideDownAndClose(to: screenHeight)
                                } else {
                                    withAnimation { offsetY = openOffset }
                                }
                            }
                    )
                    .onAppear {
                        // ✅ 처음 등장 시 애니메이션으로 등장
                        withAnimation { offsetY = openOffset }
                    }
                    .transition(.move(edge: .bottom)) // 아래에서 등장
                    .zIndex(10)
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            
        }
    }
    
    // ✅ 모달을 닫는 함수 (애니메이션 + isVisible false)

    private func slideDownAndClose(to screenHeight: CGFloat) {
        withAnimation { offsetY = screenHeight }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isVisible = false
        }
    }
}

struct SecondModalPreviewWrapper: View {
    @State private var isVisible = true
    
    var body: some View {
        ZStack {
            Image("whaleBackground")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
            
            Button("모달 열기") {
                isVisible = true
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            
            SecondModalView(isVisible: $isVisible)
        }
    }
}

#Preview {
    SecondModalPreviewWrapper()
}


