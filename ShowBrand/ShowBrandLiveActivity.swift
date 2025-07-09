//
//  ShowBrandLiveActivity.swift
//  ShowBrand
//
//  Created by 정태주 on 7/9/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ShowBrandAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ShowBrandLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ShowBrandAttributes.self) { context in
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

extension ShowBrandAttributes {
    fileprivate static var preview: ShowBrandAttributes {
        ShowBrandAttributes(name: "World")
    }
}

extension ShowBrandAttributes.ContentState {
    fileprivate static var smiley: ShowBrandAttributes.ContentState {
        ShowBrandAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ShowBrandAttributes.ContentState {
         ShowBrandAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ShowBrandAttributes.preview) {
   ShowBrandLiveActivity()
} contentStates: {
    ShowBrandAttributes.ContentState.smiley
    ShowBrandAttributes.ContentState.starEyes
}
