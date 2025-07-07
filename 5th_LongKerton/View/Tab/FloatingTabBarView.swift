//
//  FloatingTabBarView.swift
//  5th_LongKerton
//
//  Created by Yehyuck Chi on 7/3/25.
//

import Foundation
import SwiftUI

struct FloatingTabBarView: View {
    @Binding var selectedTab: String
    

    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                selectedTab = "main"
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(selectedTab == "main" ? Color.pageDarkBlue:Color.myHomeGray)
                    .frame(width: 120, height: 40)
                    .overlay(
                        Text("HOME")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(selectedTab == "main" ? Color.white:Color.pageBlue)
                    )
            }
            Button {
                selectedTab = "scrap"
            } label: {
                Circle()
                    .fill(selectedTab == "scrap" ? Color.pageDarkBlue:Color.myHomeGray)
                    .frame(width: 40, height: 40)
            }
            Button{
                selectedTab = "my"
            } label: {
                RoundedRectangle(cornerRadius: 16)
                    .fill(selectedTab == "my" ? Color.pageDarkBlue:Color.myHomeGray)
                    .frame(width: 120, height: 40)
                    .overlay(
                        Text("MY PAGE")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(selectedTab == "my" ? Color.white:Color.pageBlue)
                    )
            }
        }
        
        
        .padding(.horizontal, 35)
        .padding(.vertical, 12)
        // Glassmorphism background
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 32, style: .continuous)
        )
        // Glassy border
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        // Soft shadow for floating effect
        .shadow(color: Color.black.opacity(0.10), radius: 8, y: 2)
        .padding(.bottom, 8)
    }
}

