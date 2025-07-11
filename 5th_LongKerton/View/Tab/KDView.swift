//import SwiftUI
//
//
//
//struct KDView: View {
//    @Binding var currentState: AppState
//    @State var selectedTab: String = "main"
////    @State var scrape: Int = 8
//    
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .bottom) {
//                switch selectedTab {
//                case "main":
//                    MainPage()
//                case "scrap":
//                    BrandScrapePage()
//                case "my":
//                    UserMainView(selectedTab: $selectedTab, currentState: $currentState)
//                default:
//                    MainPage()
//                }
//                FloatingTabBarView(selectedTab: $selectedTab)
//                    .padding(.horizontal, 20)
//            }
//            .animation(.easeInOut(duration: 0.4), value: selectedTab)
//        }
//    }
//}
//
//#Preview {
//    KDView(currentState: .constant(.main))
//}

import SwiftUI

struct KDView: View {
    @Binding var currentState: AppState
    @Binding var previousState: AppState
    @State private var selectedTab: String = "main"
    @State private var refreshTrigger: Bool = false // 모든 페이지에서 공유하는 새로고침 트리거

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                switch selectedTab {
                case "main":
                    MainPage(currentState: $currentState, previousState: $previousState)
                case "scrap":
                    BrandScrapePage(currentState: $currentState,  previousState: $previousState)
                case "my":
                    UserMainView(selectedTab: $selectedTab, currentState: $currentState, previousState: $previousState)
                default:
                    MainPage(currentState: $currentState, previousState: $previousState)
                }
                FloatingTabBarView(selectedTab: $selectedTab)
                    .padding(.horizontal, 20)
            }
            .animation(.easeInOut(duration: 0.4), value: selectedTab)
        }
    }
}
