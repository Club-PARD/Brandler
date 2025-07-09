//
//  ShowBrandBundle.swift
//  ShowBrand
//
//  Created by 정태주 on 7/9/25.
//

import WidgetKit
import SwiftUI

@main
struct ShowBrandBundle: WidgetBundle {
    var body: some Widget {
        ShowBrand()
        ShowBrandControl()
        ShowBrandLiveActivity()
    }
}
