import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack{
            VStack {
                
                Spacer().frame(height: 180)
                
                // 고래 + 설명 텍스트 (leading 맞춤)
                VStack(alignment: .leading, spacing: 12) {
                    //Spacer().frame(height: 100)
                    Text("고래")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(white: 0.9))
                        .cornerRadius(4)
                    
                    Text("하나의 브랜드가 당신과 닿는 순간,\n취향은 이제 탐험이 아닌 연결이")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 36)
                
                Spacer().frame(height: 32)
                
                // 타이포 로고 버튼
                HStack {
                    Spacer().frame(width: 36) // 왼쪽 여백을 고래와 동일하게
                    Text("타이포 로고")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color(white: 0.9))
                        .cornerRadius(6)
                    Spacer().frame(width: 36) // 오른쪽 여백
                }
                
                Spacer().frame(height: 100)
                
                // Apple 로그인 버튼
                HStack {
                    Spacer().frame(width: 16)
                    Button(action: {
                        // Apple 로그인 액션
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                                .font(.title2)
                                .padding(.horizontal, 20)
                            Spacer()
                            Text("Apple로 시작하기")
                                .font(.body)
                                .fontWeight(.medium)
                                .padding(.trailing, 110)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color.black)
                        .cornerRadius(10)
                    }
                    Spacer().frame(width: 16)
                }
                
                Spacer()
            }
            .background(Color.white.ignoresSafeArea())
        }
        
    }
}

#Preview {
    LoginView()
}
