// 📁 View/TabBar/CategoryTabBarView.swift

import SwiftUI

struct CategoryTabBarView: View {
    @Binding var selected: Category

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Category.allCases) { category in
                    Button(action: {
                        selected = category
                    }) {
                        Text(category.rawValue)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .foregroundColor(
                                selected == category ? .white : .gray
                            )
                            .background(
                                selected == category ? Color.blue : Color.clear
                            )
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 16)
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
