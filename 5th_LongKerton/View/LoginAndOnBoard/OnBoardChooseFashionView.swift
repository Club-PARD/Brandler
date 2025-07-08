import SwiftUI

struct OnBoardChooseFashionView: View {
    let goToNext: () -> Void
    @Binding var selectedGenre: String
    var currentStep: Int = 1 // 0, 1, 2 중 현재 단계

    
    let genres = [
        ["아메카지", "스트릿", "빈티지"],
        ["히피", "포멀", "페미닌"],
        ["캐주얼", "테크", "기타"]
    ]
    
    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                
                // 동그라미 인디케이터
                HStack(spacing: 8) {
                    ForEach(0..<3) { idx in
                        Circle()
                            .fill(idx == currentStep ? Color.barBlue : Color.barBlack)
                            .frame(width: 10, height: 10)
                    }
                }
                .frame(height: 56)
                .padding(.horizontal, 16)
                .padding(.bottom, 25)

                
                HStack {
                    Text("관심있는 패션 장르를\n선택해주세요")
                        .font(.custom("Pretendard-Regular",size: 22))
                        .foregroundColor(.NickWhite)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.leading, 24)
                .padding(.bottom, 36)
                
                //버튼 선택하기
                VStack(spacing: 16) {
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
                                        .frame(maxWidth: .infinity, minHeight: 100)
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
                
                Spacer()
                
                Button(action: {
                    goToNext()
                }) {
                    Text("다음으로")
                        .font(.custom("Pretendard-SemiBold",size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color.NextButton)
                        .cornerRadius(100)
                }
                .padding(.horizontal, 25)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnBoardChooseFashionView(goToNext: {}, selectedGenre: .constant(""))
}

