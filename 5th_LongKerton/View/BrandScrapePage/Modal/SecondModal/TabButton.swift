//
//  Tab.swift
//  BrandScrapePage
//
//  Created by 정태주 on 7/3/25.
//
import SwiftUI



@ViewBuilder
func TabButton(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
    Button(action: {
        withAnimation(.easeInOut(duration: 0.3)) {
            action()
        }
    }) {
        VStack(spacing: 0) {
            Spacer()
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color.TabPurple)
            Spacer()
        }
        .frame(height: selected ? 56 : 40)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 4)
        .background(
            Group {
                if selected {
                    TopRoundedRectangle(radius: 12)
                        .fill(Color.LogBlue.opacity(0.6))
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.TabGray)
                }
            }
        )
        .overlay(
            Group {
                if selected {
                    StrokeExcludingBottom(radius: 16)
                        .stroke(Color.LogBlue, lineWidth: 1)
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.LogBlue, lineWidth: 1)
                }
            }
        )
//        .animation(.easeInOut(duration: 0.3), value: selected)
    }
}


