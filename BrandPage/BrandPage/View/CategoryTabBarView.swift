// 📁 View/TabBar/CategoryTabBarView.swift

import SwiftUI

struct CategoryTabBarView: View {
    @Binding var selected: Category

    var body: some View {
        HStack(spacing: 12) {
            ForEach(Category.allCases) { category in
                Button(action: {
                    selected = category
                }) {
                    Text(category.rawValue)
                        .fontWeight(.semibold)
                        .frame(width: 80, height: 36)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(selected == category ? Color(hex: "#C4D1FF") : Color(hex: "#6D6D6D"))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color(hex: "#C4D1FF"), lineWidth: 1)
                        )
                        .foregroundColor(
                            selected == category ? Color(hex: "#002FFF") : Color(hex: "#C4D1FF")
                        )
                }
            }
        }
       // .padding(.horizontal)
        //.padding(.top, 12)
        .frame(height: 70)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#1B191A"))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selected: Category = .all

        var body: some View {
            CategoryTabBarView(selected: $selected)
                .background(Color.black)
        }
    }

    return PreviewWrapper()
}
