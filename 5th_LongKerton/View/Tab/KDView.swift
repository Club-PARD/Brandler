import SwiftUI

enum Tab {
    case main
    case scrap
    case my
}

struct KDView: View {
    @Binding var currentState: AppState
    @State var selectedTab: String = "main"
    @State var scrape: Int = 8

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                switch selectedTab {
                case "main":
                    MainPage()
                case "scrap":
                    BrandScrapePage()
                case "my":
                    UserMainView(selectedTab: $selectedTab, currentState: $currentState, scrape: scrape)
                default:
                    MainPage()
                }
                FloatingTabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    KDView(currentState: .constant(.main))
}
