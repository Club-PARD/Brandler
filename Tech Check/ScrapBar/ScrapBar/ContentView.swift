//
//  ContentView.swift
//  ScrapBar
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ScrapViewModel()

    var body: some View {
        VStack(spacing: 20) {
            ScrapProgressBar(currentScrap: viewModel.currentScrap, maxScrap: viewModel.maxScrap)

            Button(action: {
                viewModel.addScrap()
            }) {
                Text("스크랩 +1")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                viewModel.removeScrap()
            }) {
                Text("스크랩 -1")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
