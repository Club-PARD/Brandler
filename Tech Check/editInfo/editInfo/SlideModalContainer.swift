//
//  Untitled.swift
//  editInfo
//
//  Created by 정태주 on 6/30/25.
//

import SwiftUI

struct SlideModalContainer: View {
    @State private var isModalExpanded = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("메인 콘텐츠 영역")
                    .font(.title)
                Spacer()
            }

            SlideHandleModal(isExpanded: $isModalExpanded)
        }
    }
}

#Preview {
    SlideModalContainer()
}
