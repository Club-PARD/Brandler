import SwiftUI

struct DiggingStepView: View {
    let step: Int
    let progress: Double
    let diggingDistanceInKM: Double

    var body: some View {
        let nextKM = step < 5 ? Double(step * 2) : 10.0
        let remaining = max(0, nextKM - diggingDistanceInKM)

        HStack(spacing: 16) {
            Image("level\(step)")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.leading)

            VStack(alignment: .leading, spacing: 12) {
                // ✅ 체크박스
                HStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { idx in
                        Spacer()
                        Image(systemName: progress * 5 > Double(idx) ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .foregroundColor(progress * 5 > Double(idx) ? .black : .gray)
                        Spacer()
                    }
                }

                // ✅ 진행률 바
                ProgressBarView(progress: progress)

                // ✅ 설명 텍스트
                HStack {
                    Spacer()
                    Text(progress >= 1.0 ?
                         "\(step)단계 고래와 만나기 완료!" :
                         (step < 5 ?
                          "\(step + 1)단계 고래와 만나기까지 \(String(format: "%.1f", remaining))km 남았어요" :
                          "고래를 모두 만나기까지 \(String(format: "%.1f", remaining))km 남았어요"))
                    .font(.caption)
                    .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: 200)

            
            Spacer()
            
        }
        .padding(.vertical, 12)
        .frame(height: 130)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
    }
}
