//
//  ConfigurationAppIntent+Preview.swift
//  5th_LongKerton
//
//  Created by 정태주 on 7/5/25.
//

import WidgetKit

// 샘플 설정
extension ConfigurationAppIntent {
    static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }

    static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

// 위젯 미리보기
#Preview(as: .systemSmall) {
    BrandShowWidget()
} timeline: {
    SimpleEntry(configuration: .smiley)
}

#Preview(as: .systemMedium) {
    BrandShowWidget()
} timeline: {
    SimpleEntry(configuration: .smiley)
}

#Preview(as: .systemLarge) {
    BrandShowWidget()
} timeline: {
    SimpleEntry(configuration: .starEyes)
}
