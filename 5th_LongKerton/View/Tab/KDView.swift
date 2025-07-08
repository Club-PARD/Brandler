//
//  TabView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/1/25.
//

import SwiftUI

enum Tab {
    case main
    case scrap
    case my
}

struct KDView:View{
    @State var selectedTab: String = "main"
    var body:some View{
        NavigationStack {
            ZStack(alignment: .bottom) {
                switch selectedTab {
                case "main":
                    MainPage()
                case "scrap":
                    BrandScrapePage()
                case "my":
                    UserMainView(selectedTab: $selectedTab)
                default:
                    MainPage()
                }
                FloatingTabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview{
    KDView()
}

