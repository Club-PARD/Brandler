
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
                    Color(white: 0.9),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 3) {
                Text("디깅 수")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(progressSteps)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color.white)
                    Text("/\(totalSteps)")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(Color(.systemGray3))
                        .padding(.leading, 2)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

struct UserMainView: View {
@ObservedObject private var session = UserSessionManager.shared
@Binding var selectedTab: String
let progressStep: Int = 4
let totalSteps = 5

@State private var showEditInfo: Bool = false
@State private var showHistoryPage: Bool = false
@State private var showScrapePage: Bool = false
@State private var showDiggingPage: Bool = false

// SecondModalView 상태
@State private var showSecondModal = false

var nickname: String {
    session.userData?.nickname ?? "닉넴 없음"
}
var genre: String {
    session.userData?.fashionGenre ?? "장르 없음"
}

var body: some View {
    ZStack {
        Color.BgColor.ignoresSafeArea()
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                // Top bar
                ZStack {
                    Text("MY PAGE")
                        .foregroundColor(Color(white: 0.7))
                        .font(.system(size: 18, weight: .medium))
                    HStack {
                        Spacer()
                        Button {
                            showEditInfo = true
                        } label: {
                            Image("setting")
                                .foregroundColor(.white)
                                .frame(width: 32, height: 32)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 15)

                Spacer()

                ZStack{
                    // 상단 프로필 카드
                    VStack {
                        HStack(alignment: .center, spacing: 0) {
                            Image("whale_char")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 160)
                                .padding(.leading, 24)

                            Spacer().frame(width: 32)

                            VStack(alignment: .leading, spacing: 24) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("닉네임")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.EditTxt)
                                        .frame(width: 70, height: 30)
                                        .background(Color.myDarkGray)
                                        .cornerRadius(10)
                                    Text(nickname)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(.white))
                                        .padding(.leading, 5)
                                }
                                .padding(.bottom, -10)
                                .padding(.top, 20)

                                Rectangle()
                                    .fill(Color(.systemGray4))
                                    .frame(height: 1)
                                    .padding(.vertical, 2)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("장르")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.EditTxt)
                                        .frame(width: 70, height: 30)
                                        .background(Color.myDarkGray)
                                        .cornerRadius(10)
                                    Text(genre)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Color(.white))
                                        .padding(.leading, 5)
                                }
                                .padding(.top, -10)
                                .padding(.bottom, 20)
                            }
                            .padding(.vertical, 8)
                            .padding(.trailing, 32)

                            Spacer()
                        }
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.myGradStart,
                                    Color.myGradEnd
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color(.systemGray4), lineWidth: 2)
                        )
                        .padding(.horizontal, 8)
                        .frame(height: 220)
                    }
                    .padding(.horizontal, 20)
                }

                // 디깅 레벨/프로그레스
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 18) {
                        Text("\(nickname) 님은 지금")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.bottom, -8)

                        ZStack(alignment: .bottomLeading) {
                            Rectangle()
                                .fill(Color.barBlue)
                                .frame(width: 170, height: 7)
                                .cornerRadius(3.5)
                                .offset(y: 2)
                            Text("🐋 심해 디깅러")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                        }

                        VStack(alignment: .leading, spacing: 0) {
                            Text("다음 레벨까지 남은 디깅 수: 1개")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(Color.white)

                            Button {
                                showSecondModal = true
                            } label: {
                                Text("단계 레벨 가이드 보기")
                                    .font(.system(size: 13, weight: .regular))
                                    .foregroundColor(Color(white: 0.7))
                                    .underline()
                                    .padding(.top, 10)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.leading, 29)
                    .padding(.trailing, 12)

                    Spacer()

                    CircularProgressBar(progressSteps: 4, totalSteps: 5, lineWidth: 14, size: 140)
                        .padding(.trailing, 40)
                }
                .padding(.bottom, 15)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.BgColor,
                        Color.myGradEnd2
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .clipShape(RoundedRectangle(cornerRadius: 40))
            )

            VStack(spacing: 0) {
                Spacer().frame(height: 5)

                // MY 디깅함
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("MY 디깅함")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.myGray)
                        Spacer()
                        Button {
                            selectedTab = "scrap"
                        } label: {
                            Text("더보기")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color.myGray)
                                .padding(.trailing, 7)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 12)

                    Spacer().frame(height: 10)

                    HStack(spacing: 12) {
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray4))
                                .frame(width: 110, height: 120)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                    Spacer().frame(height: 8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.myHomeGray)
                        )
                )
                .padding(.horizontal, 18)
                .padding(.bottom, 12)

                Spacer().frame(height: 8)

                // 최근 본 브랜드
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("최근 본 브랜드")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.myGray)
                        Spacer()
                        Button {
                            showHistoryPage = true
                        } label: {
                            Text("더보기")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(Color.myGray)
                                .padding(.trailing, 7)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 12)
                    Spacer().frame(height: 10)

                    HStack(spacing: 12) {
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(.systemGray4))
                                .frame(width: 110, height: 120)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 12)
                    Spacer().frame(height: 8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.myHomeGray)
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

        // SecondModalView를 조건부로 표시
        if showSecondModal {
            SecondModalView(isVisible: $showSecondModal)
                .zIndex(10)
        }
    }
    .animation(.easeInOut, value: showSecondModal)
    .navigationDestination(isPresented: $showEditInfo) {
        EditInfoView()
    }
    .navigationDestination(isPresented: $showHistoryPage) {
        HistoryPage()
    }
    .navigationDestination(isPresented: $showDiggingPage) {
        BrandScrapePage()
    }
    .navigationDestination(isPresented: $showScrapePage) {
        BrandScrapePage()
    }
}
}

// 프리뷰용
#Preview {
UserMainView(selectedTab: .constant("home"))
}

