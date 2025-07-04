//
//  FlipCardItemView.swift
//  BrandPage
//
//  Created by 정태주 on 7/2/25.
//

import SwiftUI

struct FlipCardItemView: View {
    // 브랜드 아이템 데이터 (frontImageName, name, price, category 등) - 읽기 전용
    let item: BrandItem
    
    // 현재 뒤집힌 카드의 UUID를 바인딩으로 받아서 상태를 공유
    // 여러 카드 중에서 어떤 카드가 뒤집혔는지 구분하는 데 사용
    @Binding var flippedID: UUID?
    
    // 삭제 버튼을 눌렀을 때 실행할 콜백 함수
    let onDelete: () -> Void

    var body: some View {
        // 실제 카드 뷰인 FlipCardView에 전달 및 렌더링
        FlipCardView(
            item: item,                  // 보여줄 아이템 데이터
            flippedID: $flippedID,       // 바인딩된 뒤집힘 상태 전달 (상호작용 가능)
            onDelete: onDelete           // 삭제 콜백 그대로 전달
        )
    }
}

// MARK: - 미리보기용 래퍼 뷰
#Preview {
    struct PreviewWrapper: View {
        // 카드 뒤집힘 상태를 관리하는 State (nil이면 카드가 뒤집혀있지 않음)
        @State private var flippedID: UUID? = nil

        var body: some View {
            FlipCardItemView(
                item: BrandItem(
                    frontImageName: "mockBanner1",  // 미리보기 이미지 이름
                    name: "테스트 아이템",             // 아이템 이름
                    price: 59000,                   // 아이템 가격
                    category: .top                  // 카테고리 (상의)
                ),
                flippedID: $flippedID,              // 뒤집힘 상태를 바인딩으로 전달
                onDelete: { print("삭제됨") }       // 삭제 시 콘솔 출력
            )
            .frame(width: 120, height: 180)        // 카드 크기 고정 (120x180)
            .background(Color.gray)                 // 배경 회색으로 표시 (미리보기 구분용)
        }
    }

    // 미리보기에서 PreviewWrapper를 렌더링하도록 반환
    return PreviewWrapper()
}
