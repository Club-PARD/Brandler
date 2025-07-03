
import SwiftUI

struct CircularProgressBar: View {
    var progressSteps: Int
    var totalSteps: Int = 5
    var lineWidth: CGFloat = 20
    var size: CGFloat = 160

    var progress: Double {
        Double(progressSteps) / Double(totalSteps)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.EditBox, lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(
                    Color.LogBlue,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 3) {
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(progressSteps)")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(Color.LogBlue)
                    Text("/\(totalSteps)")
                        .font(.system(size: 38, weight: .regular))
                        .foregroundColor(Color(.systemGray3))
                        .padding(.leading, 2)
                }
                Text("디깅 수")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.white)
            }
        }
        .frame(width: size, height: size)
    }
}

struct FloatingTabBar: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.myHomeGray)
                .frame(width: 100, height: 36)
                .overlay(
                    Text("HOME")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                )
            Circle()
                .fill(Color.myHomeGray)
                .frame(width: 36, height: 36)
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.pageDarkBlue)
                .frame(width: 100, height: 36)
                .overlay(
                    Text("MY PAGE")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.pageBlue)
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        // Glassmorphism background
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 32, style: .continuous)
        )
        // Glassy border
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        // Soft shadow for floating effect
        .shadow(color: Color.black.opacity(0.10), radius: 8, y: 2)
        .padding(.bottom, 8)
    }
}





struct UserMainView: View {
    @ObservedObject private var session = UserSessionManager.shared

    let progressStep: Int = 4
    let totalSteps = 5

    @State private var showEditInfo: Bool = false

    var nickname: String {
        session.userData?.nickname ?? ""
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.BgColor.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 16)

                        // 상단 제목 & setting 버튼
                        HStack {
                            Spacer()
                            Text(nickname)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.LogBlue)
                            Spacer()
                            Button {
                                showEditInfo = true
                            } label: {
                                Image("setting")
                                    .foregroundColor(.white)
                                    .frame(width: 32, height: 32)
                            }
                        }
                        .padding(.horizontal, 16)

                        Spacer().frame(height: 18)
                        Divider()
                            .frame(height: 1)
                            .background(Color.white)
                            .padding(.bottom, 14)

                        HStack(alignment: .bottom, spacing: 0) {
                            // 캐릭터 + "디깅 캐릭터"
                            VStack {
                                Spacer()
                                Image("whale_char")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 200)
                                Text("디깅 캐릭터")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.LogBlue)
                                    .padding(.vertical, 14)
                                    .frame(height: 28)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                            .padding(.trailing, 10)
                            .padding(.bottom, 10)

                            // 프로그레스 바 + "디깅 레벨"
                            VStack {
                                Spacer()
                                CircularProgressBar(progressSteps: progressStep, totalSteps: totalSteps)
                                Spacer()
                                Text("디깅 레벨")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.LogBlue)
                                    .padding(.vertical, 14)
                                    .frame(height: 28)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                            .padding(.trailing, 10)
                            .padding(.bottom, 10)
                        }
                        .frame(height: 260)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.barBlue, lineWidth: 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.myGray)
                                )
                        )
                        .padding(.horizontal, 18)

                        Spacer().frame(height: 22)

                        // 메인 안내 텍스트
                        HStack(spacing: 0) {
                            Text(nickname)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Color.LogBlue)
                            Text(" 님은 지금")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(Color.LogBlue)
                        }
                        .padding(.bottom, 8)

                        // 심해 디깅러 버튼
                        VStack{
                            Text("심해 디깅러")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                            Text("다음 레벨까지 남은 디깅 수: 1")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(Color.LogBlue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.barBlue)
                        .cornerRadius(8)
                        .padding(.horizontal, 18)

                        // 단계 레벨 가이드
                        Text("단계 레벨 가이드 보기")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(.systemGray3))
                            .underline()
                            .padding(.top, 5)
                            .padding(.bottom, 30)

                        // MY 디깅함
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("MY 디깅함")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.LogBlue)
                                Spacer()
                                Text("더보기")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(Color(.systemGray3))
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 12)

                            Spacer().frame(height: 10)

                            HStack(spacing: 12) {
                                ForEach(0..<3) { _ in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray4))
                                        .frame(width: 100, height: 85)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.LogBlue, lineWidth: 1)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.myGray)
                                )
                        )
                        .padding(.horizontal, 18)
                        .padding(.bottom, 12)

                        // 최근 본 브랜드
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("최근 본 브랜드")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.LogBlue)
                                Spacer()
                                Text("더보기")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(Color(.systemGray3))
                            }
                            .padding(.top, 10)
                            .padding(.horizontal, 12)

                            Spacer().frame(height: 10)

                            HStack(spacing: 12) {

                                ForEach(0..<3) { _ in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray4))
                                        .frame(width: 100, height: 85)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 12)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.LogBlue, lineWidth: 1)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.myGray)
                                )
                        )
                        .padding(.horizontal, 18)

                        // 중앙 명언
                        VStack {
                            Spacer()
                            Text("Fashions fade, style is eternal.\n– Yves Saint Laurent")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .italic()
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer()
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 60)
                }

                // 플로팅 탭 바
                VStack {
                    Spacer()
                    FloatingTabBar()
                        .padding(.bottom, -30)
                }
            }
            .navigationDestination(isPresented: $showEditInfo) {
                EditInfoView()
            }
        }
    }
}

#Preview {
    UserMainView()
}
