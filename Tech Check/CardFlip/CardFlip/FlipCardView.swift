import SwiftUI // SwiftUI 프레임워크 임포트

// FlipCardView: 카드 앞/뒷면을 3D 회전으로 전환하는 뷰
struct FlipCardView: View {
    @State private var flipped = false // 카드가 뒤집혔는지 여부
    @State private var rotation = 0.0 // 현재 카드의 회전 각도 (도 단위)

    var body: some View {
        ZStack {
            // 앞면 카드
            CardFront()
                .opacity(rotation <= 90 ? 1 : 0) // 앞면은 회전 각이 0~90도일 때만 보임
                .rotation3DEffect(
                    .degrees(rotation), // 회전 각도
                    axis: (x: 0, y: 1, z: 0) // Y축 기준으로 3D 회전
                )

            // 뒷면 카드
            CardBack()
                .opacity(rotation > 90 ? 1 : 0) // 뒷면은 회전 각이 91~180도일 때만 보임
                .rotation3DEffect(
                    .degrees(rotation + 180), // 회전한 상태에서 뒤집힌 방향으로 보이도록 180도 추가
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .frame(width: 200, height: 300) // 카드 크기 지정
        .onTapGesture {
            // 탭 시 회전 애니메이션 실행
            withAnimation(.easeInOut(duration: 0.6)) {
                rotation += 180
                if rotation > 180{
                    rotation = 0
                }// 회전 각도 누적 (180도 단위로 회전)
                flipped.toggle() // 상태도 변경 (로직 상 사용, UI는 rotation 기준)
            }
        }
    }
}

// CardFront: 카드 앞면 뷰
struct CardFront: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue) // 파란색 배경
            Text("앞면")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

// CardBack: 카드 뒷면 뷰
struct CardBack: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.orange) // 주황색 배경
            Text("뒷면")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}

// SwiftUI Canvas에서 미리보기
#Preview {
    FlipCardView()
}
