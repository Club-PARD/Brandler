//
//  BrandShowWidgetBundle.swift
//  BrandShowWidget
//
//  Created by 정태주 on 7/5/25.
//

import WidgetKit
import SwiftUI

@main
struct BrandShowWidgetBundle: WidgetBundle {
    var body: some Widget {
        BrandShowWidget()
        BrandShowWidgetControl()
        BrandShowWidgetLiveActivity()
    }
}
