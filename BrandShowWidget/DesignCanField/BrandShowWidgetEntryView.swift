//
//  BrandShowWidgetEntryView.swift
//  5th_LongKerton
//
//  Created by 정태주 on 7/5/25.
//

import SwiftUI
import WidgetKit

struct BrandShowWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallView
        case .systemMedium:
            mediumView
        case .systemLarge:
            largeView
        default:
            smallView
        }
    }

    var smallView: some View {
        ZStack {
            Rectangle()
                .frame(width: 200, height: 200)
                .Color.
            VStack {
                Text("😀")
                    .font(.largeTitle)
                Text("디깅 추천")
                    .font(.caption)
            }
        }
    }

    var mediumView: some View {
        HStack {
            Text(entry.configuration.favoriteEmoji)
                .font(.system(size: 50))
            VStack(alignment: .leading) {
                Text("나의 위젯")
                Text("디깅 결과 표시")
                    .font(.headline)
            }
        }
        .padding()
        .background(Color.green.opacity(0.0))
    }

    var largeView: some View {
        VStack(spacing: 8) {
            Text("💬 나의 위젯")
                .font(.title3)
            Text("좋아하는 이모지: \(entry.configuration.favoriteEmoji)")
            Text("디깅 요약 보기")
        }
        .padding()
        .background(Color.orange.opacity(0.1))
    }
}
