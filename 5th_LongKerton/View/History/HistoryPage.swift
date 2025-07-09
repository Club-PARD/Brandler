
import SwiftUI

struct HistoryPage: View {
    @ObservedObject private var session = UserSessionManager.shared
    @StateObject private var getViewModel = GetBrandListViewModel()
    @State private var historyList: [BrandCard] = []
    @Environment(\.dismiss) var dismiss
    private var userEmail :String {
        session.userData?.email ?? "22200843@handong.ac.kr"
    }


    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                // 상단 바
                HStack {
                    Button(action: {
                        dismiss() // Dismiss the view (go back)
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
                            ForEach(historyList, id:\.brandId) { history in
//                                Navigation/Link(destination: BrandPage(brand: history)){
                                    HStack {
                                        Image(history.brandLogo)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.trailing, 21)
                                        Text(history.brandName)
                                            .font(.custom("Pretendard-SemiBold",size: 15))
                                            .foregroundColor(.white)
                                    }
//                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 0)
                    }
                    .scrollIndicators(.hidden)
                    Spacer()
                }
            }
            .task{
                do{
                    historyList = try await getViewModel.getRecentList(userEmail)
                } catch {
                    print("❌ Get Error: \(error)")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HistoryPage()
}

