import SwiftUI

struct BrandInfoOverlayView: View {
    let scrollOffset: CGFloat
    let bannerHeight: CGFloat

    @State private var showFullText = false
    @State private var isLiked = false

    let descriptionText = "힙하고 유니크한 감성을 담은 브랜드입니다. 브랜드의 미학을 기반으로 자유롭고 실험적인 스타일을 추구합니다. 감성과 철학이 담긴 디자인으로 사용자와 소통합니다."

    var body: some View {
        let textColor = Color.white

        VStack(alignment: .leading, spacing: 8) {
            Image("brandLogo")
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 4)
                .padding(.bottom, 7)

            HStack(alignment: .center) {
                Text("브랜드이름")
                    .font(.system(size: 35))
                    .foregroundColor(textColor)

//                Spacer(minLength: 39)

                Image("level1")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding(.bottom, 10)

            HStack(alignment: .top) {
                if showFullText {
                    HStack(spacing: 0) {
                        Text(descriptionText)
                            .font(.system(size: 12))
                            .foregroundColor(textColor)

                        Text("   닫기")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .bold()
                    }
                    .onTapGesture {
                        withAnimation {
                            showFullText = false
                        }
                    }
                } else {
                    HStack(spacing: 0) {
                        Text(truncatedText + "... ")
                            .font(.system(size: 12))
                            .foregroundColor(textColor)

                        Text("더보기")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .bold()
                    }
                    .onTapGesture {
                        withAnimation {
                            showFullText = true
                        }
                    }
                }

                Spacer(minLength: 65)

                Button(action: {
                    withAnimation {
                        isLiked.toggle()
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 30))
                        .foregroundColor(isLiked ? .blue : .white)
                        .offset(x: -20)
                }
                .padding(.leading, 5)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.0))
        .cornerRadius(12)
        .shadow(radius: 8)
       // .opacity(1.0 - progress * 0.3)  // 수정된 부분: 1을 1.0으로 변경
    }

    var truncatedText: String {
        if descriptionText.count > 60 {
            let index = descriptionText.index(descriptionText.startIndex, offsetBy: 60)
            return String(descriptionText[..<index])
        } else {
            return descriptionText
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var scrollOffset: CGFloat = 0
        let bannerHeight: CGFloat = 500

        var body: some View {
            ZStack {
                Image("brandBanner")
                    .resizable()
                    .scaledToFill()
                    .frame(height: bannerHeight)
                    .clipped()

                BrandInfoOverlayView(
                    scrollOffset: scrollOffset,
                    bannerHeight: bannerHeight
                )

                VStack {
                    Spacer()
                    Slider(value: $scrollOffset, in: 0...300)
                        .padding()
                }
            }
            .frame(height: bannerHeight)
            .background(Color.black)
        }
    }

    return PreviewWrapper()
}
