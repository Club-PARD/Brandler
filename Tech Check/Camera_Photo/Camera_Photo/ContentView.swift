//
//  ContentView.swift
//  Camera_Photo
//
//  Created by 정태주 on 6/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showPicker = false
    @State private var image: UIImage?
    @State private var useCamera = false

    var body: some View {
        VStack(spacing: 20) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 300)
                    .overlay(Text("이미지를 선택하세요").foregroundColor(.gray))
                    .cornerRadius(12)
            }

            HStack(spacing: 20) {
                Button("📷 카메라") {
                    useCamera = true
                    showPicker = true
                }

                Button("🖼️ 갤러리") {
                    useCamera = false
                    showPicker = true
                }
            }
            .buttonStyle(.borderedProminent)

            if image != nil {
                Button("💾 사진 저장") {
                    if let img = image {
                        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                    }
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .sheet(isPresented: $showPicker) {
            ImagePicker(image: $image, sourceType: useCamera ? .camera : .photoLibrary)
        }
    }
}

#Preview {
    ContentView()
}
