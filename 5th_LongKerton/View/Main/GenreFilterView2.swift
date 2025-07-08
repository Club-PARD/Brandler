
//
//  Untitled.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/2/25.
//


import SwiftUI

struct GenreFilterView2: View {
    @State private var showMoreFilters: Bool = true
    @Binding var selectedFilter: String // "All"
    
    let allFilters: [String] = ["전체", "아메카지", "스트릿", "빈티지", "히피", "포멀", "페미닌", "테크", "펑크", "기타"]
    
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                showMoreFilters.toggle()
            }) {
                Image("Filter") // Filter icon
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(2)
            }
            if showMoreFilters {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                    ForEach(allFilters, id: \.self) { filter in
                        Button(action: {
                            selectedFilter = filter
                        }) {
                            Text(filter)
                                .font(.custom("Pretendard-SemiBold.ttf",size: 12))
                                .frame(width:70,height:30)
                                .background(selectedFilter == filter ? Color("SelectedGenreBackColor") : Color("NotGenreBackColor"))
                                .foregroundColor(selectedFilter == filter ? Color(.white) :Color("NotGenreTextColor"))
                                .cornerRadius(10)
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth:.infinity)
                .transition(.opacity.combined(with: .slide)) // Add a subtle animation
            }
            else {
                Button(action: {
                    selectedFilter = "전체"
                    showMoreFilters = false // Collapse other filters when "All" is selected
                }) {
                    Text(selectedFilter)
                        .font(.custom("Pretendard-SemiBold.ttf",size: 12))
                        .frame(width: 70, height: 30)
                        .background(Color("SelectedGenreBackColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.BgColor.edgesIgnoringSafeArea(.all)) // Dark background for the whole view
    }
}
