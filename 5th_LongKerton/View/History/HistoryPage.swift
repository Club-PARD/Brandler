
import SwiftUI

struct HistoryPage: View {
    var History: [MockBrand] = MockBrand.sampleData
    @Environment(\.dismiss) var dismiss


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
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color(white: 0.9))
                    }
                    
                    Spacer().frame(width: 22)
                    Text("최근 본 브랜드")
                        .foregroundColor(Color(white: 0.7))
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer().frame(width: 8)
                    Color.clear
                        .frame(width: 32, height: 32)
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 40)
                
                

                // 브랜드 리스트 또는 빈 상태 메시지
                if History.isEmpty {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("아직 본 브랜드가 없어요")
                            .foregroundColor(Color(white: 0.5))
                            .font(.system(size: 16, weight: .regular))
                        Spacer()
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            ForEach(History) { history in
                                HStack {
                                    Image(history.logoImageName)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.trailing, 10)
                                    Text(history.name)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 0)
                    }
                    .scrollIndicators(.hidden)
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HistoryPage()
}

