//
//  AppIntent.swift
//  ShowBrand
//
//  Created by 정태주 on 7/9/25.
//

import WidgetKit         // 위젯 구성을 위한 프레임워크
import AppIntents        // AppIntent 기반의 사용자 정의 설정을 만들기 위한 프레임워크

/// `ConfigurationAppIntent`는 사용자가 위젯 설정에서 조정할 수 있는 항목을 정의합니다.
///
/// 이 구조체는 `WidgetConfigurationIntent`를 채택하여,
/// 위젯이 사용자로부터 입력을 받을 수 있도록 만듭니다.
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    
    /// 위젯 설정 화면에 표시될 제목입니다.
    /// 예: 위젯 갤러리에서 "Configuration"이라는 이름으로 표시됨.
    static var title: LocalizedStringResource { "Configuration" }

    /// 위젯 설정 설명입니다.
    /// 위젯 갤러리에서 이 위젯이 어떤 역할을 하는지 설명하는 문구입니다.
    static var description: IntentDescription { "This is an example widget." }

    /// 사용자가 선택할 수 있는 설정 값입니다.
    /// - title: 위젯 설정 화면에 표시되는 이름 (예: "Favorite Emoji")
    /// - default: 설정하지 않았을 때 기본으로 사용할 값
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
