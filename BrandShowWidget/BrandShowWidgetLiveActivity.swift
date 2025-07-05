//
//  BrandShowWidgetLiveActivity.swift
//  BrandShowWidget
//
//  Created by 정태주 on 7/5/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BrandShowWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BrandShowWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BrandShowWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension BrandShowWidgetAttributes {
    fileprivate static var preview: BrandShowWidgetAttributes {
        BrandShowWidgetAttributes(name: "World")
    }
}

extension BrandShowWidgetAttributes.ContentState {
    fileprivate static var smiley: BrandShowWidgetAttributes.ContentState {
        BrandShowWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BrandShowWidgetAttributes.ContentState {
         BrandShowWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BrandShowWidgetAttributes.preview) {
   BrandShowWidgetLiveActivity()
} contentStates: {
    BrandShowWidgetAttributes.ContentState.smiley
    BrandShowWidgetAttributes.ContentState.starEyes
}
