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

struct TabView:View{
    @State var selectedTab: String = "main"
    var body:some View{
        ZStack(alignment: .bottom){
            switch selectedTab{
            case "main":
                MainPage()
//            case "scrap":
//                
            case "my":
                UserMainView()
                
            default:
                MainPage()
            }
            TabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview{
    TabView()
}
