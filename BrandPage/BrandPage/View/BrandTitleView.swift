//
//  BrandTitleView.swift
//  BrandPage
//
//  Created by 정태주 on 7/2/25.
//

import SwiftUI

struct BrandTitleView: View {
    @EnvironmentObject var viewModel: BrandPageViewModel

    var body: some View {
        VStack(spacing: 8) {
            Text("아메카지 가뭐지에대")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(viewModel.interpolatedColor)

            Text("낡을수록 멋이 되는 옷, 시간이 흘러도 흐려지지 않는 실루엣.\n단단한 원단과 투박한 디테일로, 당신의 일상을 오래 지켜줄 유니폼을 만듭니다.")
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .foregroundColor(viewModel.interpolatedColor)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity)
        .offset(y: viewModel.scrollOffset <= 100 ? 0 : -viewModel.scrollOffset + 100)
        .animation(.easeOut(duration: 0.25), value: viewModel.scrollOffset)
    }
}

#Preview {
    BrandTitleView()
        .environmentObject(BrandPageViewModel())
}
