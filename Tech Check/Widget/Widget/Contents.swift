import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("🧩 위젯 전용 앱")
                .font(.title)
                .bold()

            Text("이 앱은 홈 화면에 표시될 위젯을 제공합니다.")
                .multilineTextAlignment(.center)
                .padding()

            Text("앱 자체는 UI가 거의 없습니다.")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
