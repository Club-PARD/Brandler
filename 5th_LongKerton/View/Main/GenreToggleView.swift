//
//  GenreToggleView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/2/25.
//

import SwiftUI

struct GenreToggleView: View {
    var selectedGenre: String = "indie"
    @State private var isExpanded = false
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // ✅ 필터 버튼 + 첫 줄 버튼
            HStack {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color("Blue"))
                        .clipShape(Circle())
                }
                
                // 항상 보이는 '전체' 버튼
                genreChip(genre: "전체")
                
                Spacer()
                
                // 도움말 아이콘
                Image(systemName: "questionmark.circle")
                    .foregroundColor(.white)
                
                // 🔹 펼쳐지는 장르 리스트
                if isExpanded {
//                    FlexibleView(data: genres.dropFirst(), spacing: 8, alignment: .leading) { genre in
//                        genreChip(genre: genre)
//                    }
//                    .padding(.top, 8)
//                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
                else{
                    Text(selectedGenre)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.blue)
                        .clipShape(Capsule())
                    
                    Spacer()
                }
            }
        }
        .padding()
    }
    private func genreChip(genre: String) -> some View {
        Button(action: {
            withAnimation {
                isExpanded = true
            }
        }) {
            Text(genre)
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(selectedGenre == genre ? Color("Blue") : Color.gray.opacity(0.5))
                .clipShape(Capsule())
        }
    }
}


#Preview {
    GenreToggleView()
}
