//
//  SimpleEntry.swift
//  5th_LongKerton
//
//  Created by 정태주 on 7/9/25.
//

import WidgetKit

/// `SimpleEntry`는 위젯에 표시될 단일 데이터를 나타냅니다.
/// `TimelineEntry`를 채택하여, 특정 시점에 위젯이 어떤 데이터를 표시할지 정의합니다.
struct SimpleEntry: TimelineEntry {
    let date: Date                     // 이 데이터 항목의 표시 시간
    let configuration: ConfigurationAppIntent  // 사용자가 선택한 설정(예: 이모지)
}
