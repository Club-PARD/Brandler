
//
//  Untitled.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/2/25.
//

import SwiftUI

struct GenreFilterView: View {
    @State private var showMoreFilters: Bool = false
    @Binding var selectedFilter: String // "All"

    let allFilters: [String] = ["전체", "Vintage", "스트릿", "빈티지", "히피", "포멀", "페미닌", "테크", "펑크"]

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            // Filter Buttons Section
            HStack(alignment: .top) {
                Button(action: {
                    showMoreFilters.toggle()
                }) {
                    Image("Filter") // Filter icon
                        .resizable()
                        .frame(width: 27, height: 26)
                        .padding(2)
                        .background(Color(red: 0, green: 0.18, blue: 1))
                        .foregroundColor(Color("StrokeColor"))
                        .clipShape(Circle())
                }
                if showMoreFilters {
                    // Wrap the additional filters in a FlowLayout or similar for better wrapping
                    // For simplicity, using a grid for now, but a custom FlowLayout would be ideal.
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                        ForEach(allFilters, id: \.self) { filter in
                            Button(action: {
                                selectedFilter = filter
                            }) {
                                Text(filter)
                                    .font(.system(size:12))
                                    .frame(width:70,height:30)
                                    .background(selectedFilter == filter ? Color.blue : Color.gray.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(13)
                            }
                        }
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
                            .font(.system(size:12))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background for the whole view
    }
}
