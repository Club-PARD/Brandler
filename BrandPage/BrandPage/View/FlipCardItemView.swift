//
//  FlipCardItemView.swift
//  BrandPage
//
//  Created by 정태주 on 7/2/25.
//

import SwiftUI

struct FlipCardItemView: View {
    let item: BrandItem
    @Binding var flippedID: UUID?
    let onDelete: () -> Void

    var body: some View {
        FlipCardView(
            item: item,
            flippedID: $flippedID,
            onDelete: onDelete
        )
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var flippedID: UUID? = nil

        var body: some View {
            FlipCardItemView(
                item: BrandItem(
                    frontImageName: "mockBanner1",
                    name: "테스트 아이템",
                    price: 59000,
                    category: .top
                ),
                flippedID: $flippedID,
                onDelete: { print("삭제됨") }
            )
            .frame(width: 120, height: 180)
            .background(Color.gray)
        }
    }

    return PreviewWrapper()
}
