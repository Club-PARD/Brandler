//
//  ContentView.swift
//  ScrapBar
//
//  Created by 정태주 on 6/29/25.
//

import Foundation

class ScrapViewModel: ObservableObject {
    @Published var currentScrap: Int = 0
    let maxScrap: Int = 100

    func addScrap() {
        if currentScrap < maxScrap {
            currentScrap += 1
        }
    }
    func removeScrap() {
        if currentScrap > 0 {
            currentScrap -= 1
        }
    }
}
