import Foundation

/// ConfigurationAppIntent에 샘플 데이터를 생성하는 편의 확장
extension ConfigurationAppIntent {
    
    /// 웃는 얼굴 이모지 샘플 설정
    static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    /// 별 눈 이모지 샘플 설정
    static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}
