import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
            Image("whaleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.8)
                .offset(x: 13)

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.BackgroundBlue.opacity(0.8),
                    Color.black.opacity(0.8)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}
