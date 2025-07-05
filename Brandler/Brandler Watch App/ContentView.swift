import SwiftUI

struct ContentView: View {
    let brands = ["ADER ERROR", "thisisneverthat", "Mmlg", "LIFUL", "NERDY"]
    let nickname = "정태주"
    let characterImageName = "person.crop.circle.fill"
    let myGenre = "힙합"
    let diggingStep = 4
    let maxDiggingStep = 5

    // 현재 시간 기준으로 브랜드를 자동으로 선택
    var currentBrand: String {
        let index = Calendar.current.component(.minute, from: Date()) % brands.count
        return brands[index]
    }

    var body: some View {
        TabView {
            // 👉 페이지 1: 내 프로필 정보
            profilePage

            // 👉 페이지 2: 시간에 따라 보여지는 브랜드 카드
            brandCardPage
        }
        .tabViewStyle(.page)
    }

    // MARK: - 프로필 페이지
    var profilePage: some View {
        VStack(spacing: 24) {
            // 닉네임 중앙
            HStack {
                Spacer()
                Text(nickname)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, 20)

            // 캐릭터
            Image(systemName: characterImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.white)

            // 장르
            Text("나의 장르: \(myGenre)")
                .font(.title3)
                .foregroundColor(.white)

            // 디깅 단계
            Text("디깅 단계: \(diggingStep) / \(maxDiggingStep)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.9), Color.gray.opacity(0.9)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    // MARK: - 브랜드 카드 페이지
    // MARK: - 브랜드 카드 페이지
    var brandCardPage: some View {
        VStack(spacing: 20) {
            Text("⏱ 지금의 추천 브랜드")
                .font(.system(size: 14))
                .foregroundColor(.white)

            // 줄인 카드 프레임
            Text(currentBrand)
                .font(.system(size: 10))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 120, height: 40) // ✅ 크기 줄임
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.7))
                        .shadow(radius: 4)
                )

            Text("현재 시간: \(Date(), formatter: timeFormatter)")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

    // 시간 포맷터
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
}

#Preview {
    ContentView()
}
