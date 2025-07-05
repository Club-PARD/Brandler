import SwiftUI

struct ScrollToTopButton: View {
    let proxy: ScrollViewProxy?
    let visible: Bool

    var body: some View {
        Group {
            if let proxy = proxy, visible {
                Button(action: {
                    withAnimation {
                        proxy.scrollTo("top", anchor: .top)
                    }
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.white).opacity(0.5)
                        .padding(12)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .zIndex(1000)
                .transition(.scale)
            }
        }
    }
}
