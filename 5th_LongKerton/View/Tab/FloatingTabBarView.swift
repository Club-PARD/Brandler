
import SwiftUI

struct FloatingTabBarView: View {
    @Binding var selectedTab: String

    var body: some View {
        HStack(spacing: 16) {
            Button {
                selectedTab = "main"
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(selectedTab == "main" ? Color.pageDarkBlue:Color.myHomeGray)
                    .frame(width: 117, height: 37)
                    .overlay(
                        Text("HOME")
                            .font(.custom("Pretendard-Semibold",size: 12))
                            .foregroundColor(selectedTab == "main" ? Color.white:Color("TabNameColor"))
                    )
            }
            Button {
                selectedTab = "scrap"
            } label: {
                Image(selectedTab == "scrap" ? "scrapButtonPressed" : "scrapButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 37, height: 37)
            }
            Button{
                selectedTab = "my"
            } label: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(selectedTab == "my" ? Color.pageDarkBlue:Color.myHomeGray)
                    .frame(width: 117, height: 37)
                    .overlay(
                        Text("MY PAGE")
                            .font(.custom("Pretendard-Semibold",size: 12))
                            .foregroundColor(selectedTab == "my" ? Color.white:Color("TabNameColor"))
                    )
            }
        }
        .padding(.horizontal, 19)
        .padding(.vertical, 12)
        .background(
            .ultraThinMaterial,
            in: Capsule()
        )
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.10), radius: 8, y: 2)
        .padding(.bottom, 8)
    }
}


