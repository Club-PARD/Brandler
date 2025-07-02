import SwiftUI

// 더 두꺼운 원형 Progress Bar
struct CircularProgressBar: View {
    var progress: Double // 0.0 ~ 1.0
    var lineWidth: CGFloat = 36
    var size: CGFloat = 230

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.white), lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.orange,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
        .frame(width: size, height: size)
    }
}

// 플로팅 탭 바
struct FloatingTabBar: View {
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 90, height: 32)
                .foregroundColor(Color(.systemGray))
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 32)
                .foregroundColor(Color(.systemGray))
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 90, height: 32)
                .foregroundColor(Color.blue)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
        .background(
            Color(.darkGray)
                .opacity(0.95)
        )
        .cornerRadius(32)
        .shadow(color: Color.black.opacity(0.08), radius: 8, y: 2)
        .padding(.bottom, 18)
    }
}

struct UserMainView: View {
    @State private var progress: Double = 0.0 // 처음엔 0
    let targetProgress: Double = 0.75         // 목표값

    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()
            VStack(spacing: 0) {
                // 상단 바
                HStack(alignment: .center, spacing: 0) {
                    // 빽버튼
                    Text("백버튼")
                        .font(.system(size: 13, weight: .medium))
                        .frame(width: 48, height: 48)
                        .background(Color(.systemGray3))
                        .cornerRadius(6)
                        .foregroundColor(.black)

                    Spacer()

                    // 프로필 + 텍스트
                    HStack(spacing: 8) {
                        Circle()
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color(.systemGray3))
                            .overlay(Text("프로필").font(.system(size: 12)))
                        Text("장마엔 종로룩 완성")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                    }

                    Spacer()

                    // 더보기
                    Text("더보기")
                        .font(.system(size: 13, weight: .medium))
                        .frame(width: 48, height: 48)
                        .background(Color(.systemGray3))
                        .cornerRadius(6)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)

                // 단계 텍스트
                Text("단계 1")
                    .font(.system(size: 17, weight: .bold))
                    .padding(.top, 8)
                Spacer().frame(height: 30)

                // 원형 프로그레스 바
                CircularProgressBar(progress: progress)
                    .padding(.top, 8)

                // 안내 텍스트
                Text("현재 어디까지 디깅 중! 디깅 중! 디깅하세요!")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)

                Spacer().frame(height: 18)

                // my 디깅함
                VStack(alignment: .leading, spacing: 0) {
                    Text("MY 디깅함")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 12)
                        .padding(.leading, 12)
                    Spacer().frame(height: 10)
                    Text("아직 없어요")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.leading, 12)
                        .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray4))
                .cornerRadius(12)
                .padding(.horizontal, 16)

                Spacer().frame(height: 14)

                // 최근 본 브랜드
                VStack(alignment: .leading, spacing: 0) {
                    Text("최근 본 브랜드")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 12)
                        .padding(.leading, 12)
                    Spacer().frame(height: 10)
                    Text("아직 없어요")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(.leading, 12)
                        .padding(.bottom, 18)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray4))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                .padding(.bottom, 18)
                Spacer()
            }

            // 플로팅 탭 바 (화면 하단)
            VStack {
                Spacer()
                FloatingTabBar()
            }
        }
        .onAppear {
            // 페이지 진입 시 애니메이션으로 0 → targetProgress
            withAnimation(.easeOut(duration: 2.5)) {
                progress = targetProgress
            }
        }
    }
}

#Preview {
    UserMainView()
}
