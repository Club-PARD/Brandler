import SwiftUI

struct OnBoardChooseFashionView: View {
    let goToNext: () -> Void
    @Binding var selectedGenre: String
    
    let genres = [
        ["아메카지", "스트릿", "빈티지"],
        ["히피", "포멀", "페미닌"],
        ["펑크", "레트로", "기타"]
    ]
    
    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                GeometryReader { geometry in
                    let totalWidth = geometry.size.width
                    let progressWidth = totalWidth * 2/3
                    VStack(spacing: 8) {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.barBlack)
                                .frame(height: 10)
                            Capsule()
                                .fill(Color.barBlue)
                                .frame(width: progressWidth, height: 10)
                        }
                    }
                    .frame(width: totalWidth)
                }
                .frame(height: 56)
                .padding(.horizontal, 18)
                .padding(.bottom, 25)
                
                HStack {
                    Text("관심있는 패션 장르를\n선택해주세요")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.LogBlue)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.leading, 18)
                .padding(.bottom, 36)
                
                //버튼 선택하기
                VStack(spacing: 16) {
                    ForEach(0..<genres.count, id: \.self) { rowIndex in
                        HStack(spacing: 16) {
                            ForEach(genres[rowIndex], id: \.self) { genre in
                                Button(action: {
                                    // Toggle selection: select if not selected, deselect if same
                                    selectedGenre = (selectedGenre == genre) ? "" : genre
                                }) {
                                    Text(genre)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.LogBlue)
                                        .frame(maxWidth: .infinity, minHeight: 100)
                                        .background(
                                            selectedGenre == genre
                                            ? Color.barBlue
                                            : Color(white: 0.6)
                                        )
                                        .cornerRadius(12)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    selectedGenre == genre
                                                    ? Color.LogBlue
                                                    : Color.clear,
                                                    lineWidth: 2
                                                )
                                        )
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 18)
                
                Spacer()
                
                Button(action: {
                    goToNext()
                }) {
                    Text("디깅하러 고고링")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color.NextButton)
                        .cornerRadius(40)
                }
                .padding(.horizontal, 16)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnBoardChooseFashionView(goToNext: {}, selectedGenre: .constant(""))
}

