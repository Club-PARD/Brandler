import SwiftUI

struct BrandCardBack: View {
    @EnvironmentObject var viewModel: BrandViewModel
    @Binding var currentState: AppState
    @Binding var previousState: AppState
    let brand: BrandCard
    let onDelete: () -> Void
    var onShop: () -> Void = {}

    @State private var showDeleteAlert = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(brand.brandBanner)
                .resizable()
                .scaledToFill()
                .frame(width: 99, height: 124)
                .opacity(0.5)
                .clipped()

            VStack {
                Spacer()

                Text(brand.slogan)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding()

                Spacer()
            }

            HStack(spacing: 8) {
                Button(action:{
                    viewModel.currentBrandId = brand.brandId
                    previousState = currentState
                    currentState = .brand
                }) {
                    Image("shop")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(6)
                        .background(Color.black.opacity(0.0))
                        .clipShape(Circle())
                }

                Spacer()

                Button(action: {
                    showDeleteAlert = true
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white).opacity(0.6)
                        .frame(width: 10, height: 10)
//                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                    Button("삭제", role: .destructive) {
                        onDelete()
                    }
                    Button("취소", role: .cancel) {}
                }
            }
            .padding(8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}
//


//import SwiftUI
//
//struct BrandCardBack: View {
//    let brand: BrandCard
//    let onDelete: () -> Void
//    var onShop: () -> Void = {}
//
//    /// MainPage에서 전달받을 새로고침 트리거 바인딩 (옵셔널)
//    var refreshTrigger: Binding<Bool>? = nil
//
//    @State private var showDeleteAlert = false
//
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            Image(brand.brandBanner)
//                .resizable()
//                .scaledToFill()
//                .frame(width: 99, height: 124)
//                .opacity(0.5)
//                .clipped()
//
//            VStack {
//                Spacer()
//                Text(brand.slogan)
//                    .font(.system(size: 10))
//                    .foregroundColor(.white)
//                    .padding()
//                Spacer()
//            }
//
//            HStack(spacing: 8) {
//                // 새로고침 트리거가 있으면 바인딩으로 넘기고, 없으면 기존 방식
//                if let refreshTrigger = refreshTrigger {
//                    NavigationLink(
//                        destination: BrandPage(
//                            brandId: brand.brandId,
//                            refreshTrigger: refreshTrigger
//                        )
//                    ) {
//                        Image("shop")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .padding(6)
//                            .background(Color.black.opacity(0.0))
//                            .clipShape(Circle())
//                    }
//                } else {
//                    NavigationLink(
//                        destination: BrandPage(brandId: brand.brandId)
//                    ) {
//                        Image("shop")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .padding(6)
//                            .background(Color.black.opacity(0.0))
//                            .clipShape(Circle())
//                    }
//                }
//
//                Spacer()
//
//                Button(action: {
//                    showDeleteAlert = true
//                }) {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.white).opacity(0.6)
//                        .frame(width: 10, height: 10)
//                        .clipShape(Circle())
//                }
//                .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
//                    Button("삭제", role: .destructive) {
//                        onDelete()
//                    }
//                    Button("취소", role: .cancel) {}
//                }
//            }
//            .padding(8)
//        }
//        .clipShape(RoundedRectangle(cornerRadius: 12))
//        .shadow(radius: 2)
//    }
//}
