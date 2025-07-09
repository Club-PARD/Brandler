//
//  FlipCardItemView.swift
//  BrandPage
//
//  Created by 정태주 on 7/2/25.
//

import SwiftUI

struct FlipCardItemView: View {
    // 브랜드 아이템 데이터 (frontImageName, name, price, category 등) - 읽기 전용
    let item: Product1
    
    // 현재 뒤집힌 카드의 UUID를 바인딩으로 받아서 상태를 공유
    // 여러 카드 중에서 어떤 카드가 뒤집혔는지 구분하는 데 사용
    @Binding var flippedID: UUID?
    

    var body: some View {
        // 실제 카드 뷰인 FlipCardView에 전달 및 렌더링
        ItemFlipCardView(
            item: item,                  // 보여줄 아이템 데이터
            flippedID: $flippedID,       // 바인딩된 뒤집힘 상태 전달 (상호작용 가능)
        )
    }
}
