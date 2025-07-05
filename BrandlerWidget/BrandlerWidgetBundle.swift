//
//  BrandlerWidgetBundle.swift
//  BrandlerWidget
//
//  Created by 정태주 on 7/5/25.
//

import WidgetKit
import SwiftUI

@main
struct BrandlerWidgetBundle: WidgetBundle {
    var body: some Widget {
        BrandlerWidget()
        BrandlerWidgetControl()
        BrandlerWidgetLiveActivity()
    }
}
