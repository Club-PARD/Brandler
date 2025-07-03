//
//  ModalImageEditorView.swift
//  editInfo
//
//  Created by 정태주 on 6/30/25.
//

import SwiftUI

struct ModalImageEditorView: View {
    @State private var isEditing = false
    @State private var showDeleteAlert = false
    @State private var imageToDelete: Int? = nil

    @State private var images: [Int] = Array(1...5) // 임시 이미지들 (Int로 표시)

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(images, id: \.self) { index in
                        ZStack(alignment: .topTrailing) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 150)
                                .overlay(Text("사진 \(index)").foregroundColor(.black))

                            if isEditing {
                                Button(action: {
                                    imageToDelete = index
                                    showDeleteAlert = true
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.red)
                                        .padding(8)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("사진 편집")
            .navigationBarItems(trailing: Button(isEditing ? "완료" : "편집") {
                isEditing.toggle()
            })
            .alert("정말 삭제할까요?", isPresented: $showDeleteAlert, actions: {
                Button("삭제", role: .destructive) {
                    if let id = imageToDelete {
                        images.removeAll { $0 == id }
                    }
                }
                Button("취소", role: .cancel) {}
            })
        }
    }
}
