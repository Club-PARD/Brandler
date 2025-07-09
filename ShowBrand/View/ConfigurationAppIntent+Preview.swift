//
//  ConfigurationAppIntent+Preview.swift
//  5th_LongKerton
//
//  Created by 정태주 on 7/9/25.
//

import Foundation

/// `ConfigurationAppIntent`를 위한 미리보기 전용 확장입니다.
/// 위젯 프리뷰에서 다양한 구성 상태를 테스트할 수 있게 도와줍니다.
extension ConfigurationAppIntent {

    /// 😀 이모지를 기본으로 설정한 구성
    static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }

    /// 🤩 이모지를 기본으로 설정한 구성
    static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

