//
//  Widget_ExtensionBundle.swift
//  Widget Extension
//
//  Created by 정태주 on 6/28/25.
//

import WidgetKit
import SwiftUI

@main
struct Widget_ExtensionBundle: WidgetBundle {
    var body: some Widget {
        Widget_Extension()
        Widget_ExtensionControl()
        Widget_ExtensionLiveActivity()
    }
}
