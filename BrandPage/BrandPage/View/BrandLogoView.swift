import SwiftUI

struct BrandLogoView: View {
    @EnvironmentObject var viewModel: BrandPageViewModel

    var body: some View {
        GeometryReader { geo in
            let pos = viewModel.logoPosition(geo: geo)
            Image("brandLogo")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .position(x: pos.x, y: pos.y)
        }
        .frame(height: viewModel.bannerHeight)
    }
}

#Preview {
    BrandLogoView()
        .environmentObject(BrandPageViewModel())
}
