
import SwiftUI

// 레벨과 진행 단계 계산용 구조체 및 함수
struct DiggingLevel {
    let levelName: String
    let progressSteps: Int
    let totalSteps: Int = 5
}



func getDiggingLevel(scrape: Int) -> DiggingLevel {
    let levels = ["🐚입문자 디깅러", "🐟취향 디깅러", "🪸 탐험 디깅러", "🐋 심해 디깅러", "🌊마스터 브랜들러"]
    let maxLevelIndex = levels.count - 1
    let cappedScrape = max(1, scrape) // 1 미만이면 1로 고정
    let levelIndex = min((cappedScrape - 1) / 5, maxLevelIndex)
    let progressSteps = ((cappedScrape - 1) % 5) + 1
    return DiggingLevel(levelName: levels[levelIndex], progressSteps: progressSteps)
}

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
                .stroke(Color(white: 0.9),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            VStack(spacing: 3) {
                Text("디깅 수")
                    .font(.custom("Pretendard-Medium",size: 10))
                    .foregroundColor(.white)
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(progressSteps)")
                        .font(.custom("Pretendard-SemiBold",size: 20))
                        .foregroundColor(Color.white)
                    Text("/\(totalSteps)")
                        .font(.custom("Pretendard-SemiBold",size: 20))
                        .foregroundColor(Color.circleStep)
                        .padding(.leading, 2)
                }
            }
        }
        .frame(width: size, height: size)
    }
}

struct UserMainView: View {
    @ObservedObject private var session = UserSessionManager.shared
    @StateObject private var getViewModel = GetBrandListViewModel()
    @Binding var selectedTab: String
    @Binding var currentState: AppState // 추가

    @State private var showEditInfo: Bool = false
    @State private var showHistoryPage: Bool = false
    @State private var showScrapePage: Bool = false
    @State private var showDiggingPage: Bool = false
    @State private var showSecondModal = false

    var nickname: String {
        session.userData?.nickname ?? "닉넴 없음"
    }
    var genre: String {
        session.userData?.fashionGenre ?? "장르 없음"
    }
    var email: String {
        session.userData?.email ?? "22200843@handong.ac.kr"
    }
    
    // 실제 scrape 값을 여기에 전달
    let scrape: Int
    var diggingLevel: DiggingLevel {
        getDiggingLevel(scrape: scrape)
    }

    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    // Top bar
                    ZStack {
                        Text("MY PAGE")
                            .foregroundColor(Color.levelGray)
                            .font(.custom("Pretendard-Bold",size: 15))
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
                                            .font(.custom("Pretendard-SemiBold",size: 10))
                                            .foregroundColor(.EditTxt)
                                            .frame(width: 70, height: 30)
                                            .background(Color.myDarkGray)
                                            .cornerRadius(10)
                                        Text(nickname)
                                            .font(.custom("Pretendard-SemiBold",size: 12))
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
                                            .font(.custom("Pretendard-SemiBold",size: 10))
                                            .foregroundColor(.EditTxt)
                                            .frame(width: 70, height: 30)
                                            .background(Color.myDarkGray)
                                            .cornerRadius(10)
                                        Text(genre)
                                            .font(.custom("Pretendard-SemiBold",size: 12))
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
                                        Color.myGradStart.opacity(0.7),
                                        Color.myGradEnd.opacity(0.7)
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
//                        .padding(.bottom, 19)
                    }

                    // 디깅 레벨/프로그레스
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading) {

                            VStack {
                                (
                                    Text("\(nickname)님")
                                        .font(.custom("Pretendard-Bold", size: 11)) // Use bold font for nickname님
                                    +
                                    Text("은 지금")
                                        .font(.custom("Pretendard-Medium", size: 11)) // Regular font for the rest
                                )
                                .foregroundColor(.white)
                            }
                            
                            

                            VStack {
                                ZStack(alignment: .bottomLeading) {
                                    Rectangle()
                                        .fill(Color.blueUnderline)
                                        .frame(width: 190, height: 7)
                                        .cornerRadius(3.5)
                                        .offset(y: 2)
                                    Text(diggingLevel.levelName)
                                        .font(.custom("Pretendard-Bold",size: 20))
                                        .foregroundColor(.white)
                                        .padding(.leading, 4)
                                    
                                }
                                .padding(.bottom, 18)
                                
                            }

                            VStack(alignment: .leading, spacing: 0) {
                                Text("다음 레벨까지 남은 디깅 수: \(5 - diggingLevel.progressSteps)개")
                                    .font(.custom("Pretendard-Medium",size: 12))
                                    .foregroundColor(Color.white)
                                    
                                Button {
                                    showSecondModal = true
                                } label: {
                                    Text("단계 레벨 가이드 보기")
                                        .font(.custom("Pretendard-Light",size: 10))
                                        .foregroundColor(Color.levelGray)
                                        .underline()
                                        .padding(.top, 10)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.bottom, 18)
                        }
                        .padding(.leading, 29)
                        .padding(.trailing, 12)
                

                        Spacer()

                        CircularProgressBar(
                            progressSteps: diggingLevel.progressSteps,
                            totalSteps: diggingLevel.totalSteps,
                            lineWidth: 20,
                            size: 120
                        )
                        .padding(.trailing, 43)
                        .padding(.top, -18)
                    
                    }
                    .padding(.bottom, 37)
                    .padding(.top, 33)
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.BgColor,
                            Color.myGradEnd2.opacity(0.7)
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
                                .font(.custom("Pretendard-SemiBold",size: 13))
                                .foregroundColor(.myGray)
                            Spacer()
                            Button {
                                selectedTab = "scrap"
                            } label: {
                                Text("더보기")
                                    .font(.custom("Pretendard-Medium",size: 10))
                                    .foregroundColor(Color.myGray)
                                    .padding(.trailing, 7)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.top, 15)
                        .padding(.horizontal, 12)

                        Spacer().frame(height: 10)

                        HStack(spacing: 12) {
                            ForEach(0..<3) { _ in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemGray4))
                                    .frame(width: 110, height: 124)
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.bottom, 17)
                        Spacer().frame(height: 8)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
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
                                .font(.custom("Pretendard-SemiBold",size: 13))
                                .foregroundColor(.myGray)
                            Spacer()
                            Button {
                                showHistoryPage = true
                            } label: {
                                Text("더보기")
                                    .font(.custom("Pretendard-Medium",size: 10))
                                    .foregroundColor(Color.myGray)
                                    .padding(.trailing, 7)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.top, 15)
                        .padding(.horizontal, 12)
                        Spacer().frame(height: 10)

                        HStack(spacing: 12) {
                            ForEach(0..<3) { _ in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(.systemGray4))
                                    .frame(width: 110, height: 124)
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.bottom, 17)
                        Spacer().frame(height: 8)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
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
                            .font(.custom("Pretendard-Regular",size: 15))
                            .italic()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                    .padding(.top, 20)
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
            EditInfoView(currentState: $currentState)
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
//
//// 프리뷰용
//#Preview {
//    UserMainView(selectedTab: .constant("home"), currentState: .constant(.main))
//}
