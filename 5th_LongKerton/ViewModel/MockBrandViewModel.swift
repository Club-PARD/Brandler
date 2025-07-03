//
//  MockBrandViewModel.swift
//  BrandScrapePage
//
//  Created by 정태주 on 7/1/25.
//

import Foundation

class BrandScrapeViewModel: ObservableObject {
    @Published var brands: [MockBrand] = MockBrand.sampleData
    @Published var filteredBrands: [MockBrand] = []
    @Published var selectedGenre: String = "전체"
    
    func filterBrands() {
        if selectedGenre == "전체" {
            filteredBrands = brands
        } else {
            filteredBrands = brands.filter { $0.genre == selectedGenre }
        }
    }
    
    var diggingCount: Int {
        brands.count
    }

    var diggingDistanceInKM: Double {
        Double(diggingCount) * 0.1 // 100m = 0.1km
    }

    var remainingDistance: Double {
        max(0, 10.0 - diggingDistanceInKM)
    }

    func deleteBrand(_ brand: MockBrand) {
        brands.removeAll { $0.id == brand.id }
    }
    var whaleLevel: Int {
            switch diggingDistanceInKM {
            case 0..<2.0: return 0
            case 2.0..<4.0: return 1
            case 4.0..<6.0: return 2
            case 6.0..<8.0: return 3
            case 8.0..<10.0: return 4
            default: return 5
            }
}
    
    var whaleImageName: String {
            "level\(whaleLevel)" // 예: whale0, whale1, ..., whale5
        }
    func progress(for step: Int) -> Double {
        let distance = diggingDistanceInKM
        let lower = Double((step - 1) * 2)
        let upper = Double(step * 2)
        
        if distance >= upper {
            return 1.0
        } else if distance <= lower {
            return 0.0
        } else {
            return (distance - lower) / 2.0
        }
    }
}
