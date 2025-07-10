//import SwiftUI
//
//struct OnBoardChooseFashionView: View {
//    let goToNext: () -> Void
//    @Binding var selectedGenre: String
//    var currentStep: Int = 1 // 0, 1, 2 중 현재 단계
//    
//    @EnvironmentObject var session: UserSessionManager
//    
//    let genres = [
//        ["아메카지", "스트릿", "빈티지"],
//        ["히피", "포멀", "페미닌"],
//        ["캐주얼", "테크웨어", "기타"]
//    ]
//    
//    var body: some View {
//        ZStack {
//            Color.BgColor.ignoresSafeArea()
//            
//            VStack(spacing: 0) {
//                
//                // 동그라미 인디케이터
//                HStack(spacing: 8) {
//                    ForEach(0..<3) { idx in
//                        Circle()
//                            .fill(idx == currentStep ? Color.barBlue : Color.barBlack)
//                            .frame(width: 10, height: 10)
//                    }
//                }
//                .padding(.horizontal, 16)
//                .padding(.bottom, 62)
//                .padding(.top, 62)
//                
//                
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("관심있는 패션 장르를")
//                            .font(.custom("Pretendard-Regular", size: 22))
//                            .foregroundColor(.NickWhite)
//                        Text("선택해주세요")
//                            .font(.custom("Pretendard-Regular",size: 22))
//                            .foregroundColor(.NickWhite)
//                    }
//                    .kerning(-0.45)
//                    .lineSpacing(4.8)
//                    Spacer()
//                }
//                .padding(.leading, 24)
//                .padding(.bottom, 25)
//                
//                //버튼 선택하기
//                VStack(spacing: 20) {
//                    ForEach(0..<genres.count, id: \.self) { rowIndex in
//                        HStack(spacing: 20) {
//                            ForEach(genres[rowIndex], id: \.self) { genre in
//                                Button(action: {
//                                    // Toggle selection: select if not selected, deselect if same
//                                    selectedGenre = (selectedGenre == genre) ? "" : genre
//                                }) {
//                                    Text(genre)
//                                        .font(.custom("Pretendard-Medium",size: 12))
//                                        .foregroundColor(.FashionText)
//                                        .frame(width: 104.51, height: 104.51)
//                                        .background(
//                                            selectedGenre == genre
//                                            ? Color.barBlue.opacity(0.3)
//                                            : Color.nickBox
//                                        )
//                                        .cornerRadius(12)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 12)
//                                                .stroke(
//                                                    selectedGenre == genre
//                                                    ? Color.barBlue
//                                                    : Color.nickBoxStroke,
//                                                    lineWidth: 2
//                                                )
//                                        )
//                                }
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 107)
//                
//                Spacer()
//                
//                Button(action: {
//                    // 장르 저장
//                    session.updateGenre(selectedGenre)
//                    goToNext()
//                }) {
//                    Text("다음으로")
//                        .font(.custom("Pretendard-SemiBold",size: 16))
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity, minHeight: 80)
//                        .background(selectedGenre.isEmpty ? Color.NextButton : Color.lastBox)
//                        .cornerRadius(100)
//                }
//                .disabled(selectedGenre.isEmpty)
//                .padding(.horizontal, 25)
//                .padding(.bottom, 6)
//                
//                
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    OnBoardChooseFashionView(goToNext: {}, selectedGenre: .constant(""))
//        .environmentObject(UserSessionManager.shared)
//}
//

import SwiftUI

struct OnBoardChooseFashionView: View {
    let goToNext: () -> Void
    @Binding var selectedGenre: String
    var currentStep: Int = 1 // 0, 1, 2 중 현재 단계
    
    @EnvironmentObject var session: UserSessionManager
    
    let genres = [
        ["아메카지", "스트릿", "빈티지"],
        ["히피", "포멀", "페미닌"],
        ["캐주얼", "테크웨어", "기타"]
    ]
    
    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 동그라미 인디케이터
                HStack(spacing: 8) {
                    ForEach(0..<3) { idx in
                        Circle()
                            .fill(idx == currentStep ? Color.barBlue : Color.barBlack)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 62)
                .padding(.top, 62)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("관심있는 패션 장르를")
                            .font(.custom("Pretendard-Regular", size: 22))
                            .foregroundColor(.NickWhite)
                        Text("선택해주세요")
                            .font(.custom("Pretendard-Regular",size: 22))
                            .foregroundColor(.NickWhite)
                    }
                    .kerning(-0.45)
                    .lineSpacing(4.8)
                    Spacer()
                }
                .padding(.leading, 24)
                .padding(.bottom, 25)
                
                // 버튼 선택하기
                VStack(spacing: 20) {
                    ForEach(0..<genres.count, id: \.self) { rowIndex in
                        HStack(spacing: 20) {
                            ForEach(genres[rowIndex], id: \.self) { genre in
                                Button(action: {
                                    // Toggle selection: select if not selected, deselect if same
                                    selectedGenre = (selectedGenre == genre) ? "" : genre
                                }) {
                                    Text(genre)
                                        .font(.custom("Pretendard-Medium",size: 12))
                                        .foregroundColor(.FashionText)
                                        .frame(width: 104.51, height: 104.51)
                                        .background(
                                            selectedGenre == genre
                                            ? Color.barBlue.opacity(0.3)
                                            : Color.nickBox
                                        )
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    selectedGenre == genre
                                                    ? Color.barBlue
                                                    : Color.nickBoxStroke,
                                                    lineWidth: 2
                                                )
                                        )
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 107)
                
               Spacer()
                
                // 기존 버튼 제거 (아래 오버레이로 이동)
            }
            
            // 버튼을 오버레이로 하단 고정 (OnBoardNickNameView와 동일)
            VStack {
                Spacer()
                Button(action: {
                    // 장르 저장
                    session.updateGenre(selectedGenre)
                    goToNext()
                }) {
                    Text("다음으로")
                        .font(.custom("Pretendard-SemiBold",size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(selectedGenre.isEmpty ? Color.NextButton : Color.lastBox)
                        .cornerRadius(100)
                }
                .disabled(selectedGenre.isEmpty)
                .padding(.horizontal, 25)
                .padding(.bottom, -20)
            }
            .ignoresSafeArea(.keyboard)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnBoardChooseFashionView(goToNext: {}, selectedGenre: .constant(""))
        .environmentObject(UserSessionManager.shared)
}
