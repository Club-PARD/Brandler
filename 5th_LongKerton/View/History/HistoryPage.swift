//import SwiftUI
//
//struct HistoryPage: View {
//    @ObservedObject private var session = UserSessionManager.shared
//    @StateObject private var getViewModel = GetBrandListViewModel()
//    @State private var historyList: [BrandCard] = []
//    @Environment(\.dismiss) var dismiss
//
//    // 브랜드페이지 네비게이션용 상태
//    @State private var selectedBrandId: Int? = nil
//
//    private var userEmail: String {
//        session.userData?.email ?? "22200843@handong.ac.kr"
//    }
//
//    var body: some View {
//        ZStack {
//            Color.BgColor.ignoresSafeArea()
//            VStack(alignment: .leading, spacing: 0) {
//                // 상단 바
//                HStack {
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .font(.custom("Pretendard-Medium",size: 18))
//                            .foregroundColor(Color(white: 0.9))
//                    }
//                    Spacer().frame(width: 22)
//                    Text("최근 본 브랜드")
//                        .foregroundColor(Color.levelGray)
//                        .font(.custom("Pretendard-Bold",size: 15))
//                        .frame(maxWidth: .infinity, alignment: .center)
//                    Spacer().frame(width: 8)
//                    Color.clear
//                        .frame(width: 32, height: 32)
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 18)
//                .padding(.bottom, 40)
//
//                // 브랜드 리스트 또는 빈 상태 메시지
//                if historyList.isEmpty {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Text("아직 본 브랜드가 없어요")
//                            .foregroundColor(Color(white: 0.5))
//                            .font(.custom("Pretendard-Regular",size: 14))
//                        Spacer()
//                    }
//                    Spacer()
//                } else {
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 24) {
//                            ForEach(historyList, id: \.brandId) { history in
//                                NavigationLink(
//                                    destination: BrandPage(brandId: history.brandId),
//                                    tag: history.brandId,
//                                    selection: $selectedBrandId
//                                ) {
//                                    HStack {
//                                        Image(history.brandLogo)
//                                            .resizable()
//                                            .frame(width: 30, height: 30)
//                                            .padding(.trailing, 21)
//                                        Text(history.brandName)
//                                            .font(.custom("Pretendard-SemiBold",size: 15))
//                                            .foregroundColor(.white)
//                                    }
//                                    .contentShape(Rectangle()) // HStack 전체 터치 가능
//                                    .onTapGesture {
//                                        selectedBrandId = history.brandId
//                                    }
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                        .padding(.horizontal, 20)
//                        .padding(.top, 0)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    .scrollIndicators(.hidden)
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal, 0) // ScrollView 자체는 양쪽 끝까지
//                    Spacer()
//                }
//            }
//            .task {
//                do {
//                    // 서버에서 최근 본 브랜드 리스트 GET
//                    historyList = try await getViewModel.getRecentList(userEmail)
//                } catch {
//                    print("❌ Get Error: \(error)")
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//

//import SwiftUI
//
//struct HistoryPage: View {
//    @ObservedObject private var session = UserSessionManager.shared
//    @StateObject private var getViewModel = GetBrandListViewModel()
//    @State private var historyList: [BrandCard] = []
//    @Environment(\.dismiss) var dismiss
//
//    // 브랜드페이지 네비게이션용 상태
//    @State private var selectedBrandId: Int? = nil
//
//    private var userEmail: String {
//        session.userData?.email ?? "22200843@handong.ac.kr"
//    }
//
//    var body: some View {
//        ZStack {
//            Color.BgColor.ignoresSafeArea()
//            VStack(alignment: .leading, spacing: 0) {
//                // 상단 바
//                HStack {
//                    Button(action: {
//                        dismiss()
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .font(.custom("Pretendard-Medium",size: 18))
//                            .foregroundColor(Color(white: 0.9))
//                    }
//                    Spacer().frame(width: 22)
//                    Text("최근 본 브랜드")
//                        .foregroundColor(Color.levelGray)
//                        .font(.custom("Pretendard-Bold",size: 15))
//                        .frame(maxWidth: .infinity, alignment: .center)
//                    Spacer().frame(width: 8)
//                    Color.clear
//                        .frame(width: 32, height: 32)
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 18)
//                .padding(.bottom, 40)
//
//                // 브랜드 리스트 또는 빈 상태 메시지
//                if historyList.isEmpty {
//                    Spacer()
//                    HStack {
//                        Spacer()
//                        Text("아직 본 브랜드가 없어요")
//                            .foregroundColor(Color(white: 0.5))
//                            .font(.custom("Pretendard-Regular",size: 14))
//                        Spacer()
//                    }
//                    Spacer()
//                } else {
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 24) {
//                            ForEach(historyList, id: \.brandId) { history in
//                                NavigationLink(
//                                    destination: BrandPage(brandId: history.brandId),
//                                    tag: history.brandId,
//                                    selection: $selectedBrandId
//                                ) {
//                                    HStack {
//                                        Image(history.brandLogo)
//                                            .resizable()
//                                            .frame(width: 30, height: 30)
//                                            .padding(.trailing, 21)
//                                        Text(history.brandName)
//                                            .font(.custom("Pretendard-SemiBold",size: 15))
//                                            .foregroundColor(.white)
//                                    }
//                                    .contentShape(Rectangle()) // HStack 전체 터치 가능
//                                    .onTapGesture {
//                                        selectedBrandId = history.brandId
//                                    }
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                        .padding(.horizontal, 20)
//                        .padding(.top, 0)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    .scrollIndicators(.hidden)
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal, 0) // ScrollView 자체는 양쪽 끝까지
//                    Spacer()
//                }
//            }
//            .task {
//                do {
//                    // 서버에서 최근 본 브랜드 리스트 GET
//                    historyList = try await getViewModel.getRecentList(userEmail)
//                } catch {
//                    print("❌ Get Error: \(error)")
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//

import SwiftUI

struct HistoryPage: View {
    @ObservedObject private var session = UserSessionManager.shared
    @StateObject private var getViewModel = GetBrandListViewModel()
    @EnvironmentObject var viewModel: BrandViewModel
    @State private var historyList: [BrandCard] = []
    @Environment(\.dismiss) var dismiss
    
    // MainPage에서 바인딩으로 받아오는 새로고침 트리거
    //    var refreshTrigger: Binding<Bool>? = nil
    
    // 브랜드페이지 네비게이션용 상태
    @State private var selectedBrandId: Int? = nil
    
    private var userEmail: String {
        session.userData?.email ?? "22200843@handong.ac.kr"
    }
    
    @Binding var currentState: AppState
    @Binding var previousState: AppState
    
    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                // 상단 바
                HStack {
                    Button(action: {
                        currentState = previousState
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.custom("Pretendard-Medium",size: 18))
                            .foregroundColor(Color(white: 0.9))
                    }
                    Spacer().frame(width: 22)
                    Text("최근 본 브랜드")
                        .foregroundColor(Color.levelGray)
                        .font(.custom("Pretendard-Bold",size: 15))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer().frame(width: 8)
                    Color.clear
                        .frame(width: 32, height: 32)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 40)
                
                // 브랜드 리스트 또는 빈 상태 메시지
                if historyList.isEmpty {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("아직 본 브랜드가 없어요")
                            .foregroundColor(Color(white: 0.5))
                            .font(.custom("Pretendard-Regular",size: 14))
                        Spacer()
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            ForEach(historyList, id: \.brandId) { history in
                                Button(action:{
                                    viewModel.currentBrandId = history.brandId
                                    previousState = currentState
                                    currentState = .brand
                                }) {
                                    HStack {
                                        Image(history.brandLogo)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.trailing, 21)
                                        Text(history.brandName)
                                            .font(.custom("Pretendard-SemiBold", size: 15))
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
//                                    .onTapGesture {
//                                        selectedBrand = history
//                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            
//                        } else {
//                            NavigationLink(
//                                destination: BrandPage(
//                                    brandId: history.brandId
//                                ),
//                                tag: history.brandId,
//                                selection: $selectedBrandId
//                            ) {
//                                HStack {
//                                    Image(history.brandLogo)
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                        .padding(.trailing, 21)
//                                    Text(history.brandName)
//                                        .font(.custom("Pretendard-SemiBold",size: 15))
//                                        .foregroundColor(.white)
//                                }
//                                .contentShape(Rectangle())
//                                .onTapGesture {
//                                    selectedBrandId = history.brandId
//                                }
//                            }
//                            .buttonStyle(PlainButtonStyle())
//                        }
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .scrollIndicators(.hidden)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 0)
                    Spacer()
                }
            }
            .task {
                do {
                    historyList = try await getViewModel.getRecentList(userEmail)
                } catch {
                    print("❌ Get Error: \(error)")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
