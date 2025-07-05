//
//  Provider.swift
//  5th_LongKerton
//
//  Created by 정태주 on 7/5/25.
//

import WidgetKit

// 타임라인 항목
struct SimpleEntry: TimelineEntry {
    let date = Date()
    let configuration: ConfigurationAppIntent
}

// 타임라인 제공자
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(configuration: configuration)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entry = SimpleEntry(configuration: configuration)
        return Timeline(entries: [entry], policy: .never)
    }
}
