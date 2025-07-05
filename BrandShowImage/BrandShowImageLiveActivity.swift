//
//  BrandShowImageLiveActivity.swift
//  BrandShowImage
//
//  Created by 정태주 on 7/5/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct BrandShowImageAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct BrandShowImageLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: BrandShowImageAttributes.self) { context in
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

extension BrandShowImageAttributes {
    fileprivate static var preview: BrandShowImageAttributes {
        BrandShowImageAttributes(name: "World")
    }
}

extension BrandShowImageAttributes.ContentState {
    fileprivate static var smiley: BrandShowImageAttributes.ContentState {
        BrandShowImageAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: BrandShowImageAttributes.ContentState {
         BrandShowImageAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: BrandShowImageAttributes.preview) {
   BrandShowImageLiveActivity()
} contentStates: {
    BrandShowImageAttributes.ContentState.smiley
    BrandShowImageAttributes.ContentState.starEyes
}
